class GroupingsController < ApplicationController
  before_action :set_grouping, only: %i[ update destroy ]
  before_action :set_groupings, only: %i[ update destroy ]
  before_action :set_group, only: %i[ update destroy ]
  before_action :authenticate_user!

  def create
    email_exist? and return
    user_exist? and return
    group = find_group(params_group_id)
    user = User.find_by(email: params_email) 
    if user
      group.groupings.create(user_id: user.id)
      redirect_to group_path(group.id), notice: t('notice.member_registration_completed', email: params_email)
    else
      render template: "groups/show"
    end
  end
  
  def update
    if @grouping.update(admin: params[:admin])
      grouping_admin_grant_or_release
    else
      render template: "groups/show"
    end
  end

  def destroy
    if @grouping.destroy
      redirect_to group_path(params_group_id), notice: t('notice.delete_member', email: @grouping.user.email)
    else
      render template: "groups/show"
    end
  end

  
  private
  
  def params_email
    params[:email]
  end

  def params_group_id
    params[:group_id]
  end
  
  # すでにメンバー登録されている場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def email_exist?
    group = find_group(params_group_id)
    redirect_to group_path(group.id), notice: t('notice.registered_as_a_member', email: params_email) if group.members.exists?(email: params_email)
  end
  
  # ユーザとして存在しない場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def user_exist?
    group = find_group(params_group_id)
    if !params_email.present?
      redirect_to group_path(group.id), notice: t('notice.email_blank')
    elsif !User.exists?(email: params_email)
      redirect_to group_path(group.id), notice: t('notice.no_email_create_an_account', email: params_email)
    end
  end

  def grouping_admin_grant_or_release
    if @grouping.admin
      redirect_to group_path(params_group_id), notice: t('notice.grant_admin_privilege', email: @grouping.user.email)
    else
      redirect_to group_path(params_group_id), notice: t('notice.release_admin_privilege', email: @grouping.user.email)
    end
  end

  # Group.find(params_group_id)の共通化
  def find_group(_group_id)
    Group.find(params_group_id)
  end

  def set_grouping
    @grouping = Grouping.find(params[:id])
  end

  def set_group
    @group = find_group(params_group_id)
  end

  def set_groupings
    group = Group.find(params_group_id)
    @groupings = group.groupings.includes(:user)
  end
end

class GroupingsController < ApplicationController
  before_action :set_grouping, only: %i[ update destroy ]
  before_action :authenticate_user!

  def create
    email_exist? and return
    user_exist? and return
    group = find_group(params_grouo_id)
    user = User.find_by(email: params_email) 
    if user
      group.groupings.create(user_id: user.id)
      redirect_to group_path(group.id), notice: t('notice.member_registration_completed', email: params_email)
    else
      redirect_to group_path(group.id)
    end
  end
  
  def update
    if @grouping.update(admin: params[:admin])
      redirect_to group_path(params_grouo_id)
    else
      redirect_to group_path(params_grouo_id)
    end
  end

  def destroy
    @grouping.destroy
    redirect_to group_path(params_grouo_id), notice: t('notice.delete_member', email: @grouping.user.email)
  end

  
  private
  
  def params_email
    params[:email]
  end

  def params_grouo_id
    params[:group_id]
  end
  
  # すでにメンバー登録されている場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def email_exist?
    group = find_group(params_grouo_id)
    redirect_to group_path(group.id), notice: t('notice.registered_as_a_member', email: params_email) if group.members.exists?(email: params_email)
  end
  
  # ユーザとして存在しない場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def user_exist?
    group = find_group(params_grouo_id)
    if !params_email.present?
      redirect_to group_path(group.id), notice: t('notice.email_blank')
    elsif !User.exists?(email: params_email)
      redirect_to group_path(group.id), notice: t('notice.no_email_create_an_account', email: params_email)
    end
  end

  # Group.find(params_grouo_id)の共通化
  def find_group(_group_id)
    Group.find(params_grouo_id)
  end

  def set_grouping
    @grouping = Grouping.find(params[:id])
  end
end

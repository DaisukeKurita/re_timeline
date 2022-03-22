class GroupingsController < ApplicationController
  before_action :set_grouping, only: %i[ update destroy ]
  before_action :set_groupings, only: %i[ update destroy ]
  before_action :set_group
  before_action :authenticate_user!
  before_action :group_admin_members?, only: %i[ update destroy ] # createアクションには実装不要か？、あった方がいい！？

  def create
    email_exist? and return
    user_exist? and return
    user = User.find_by(email: params[:email]) 
    if user
      @group.groupings.create(user_id: user.id)
      redirect_to group_path(@group.id), notice: t('notice.member_registration_completed', email: params[:email])
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
      redirect_to group_path(params[:group_id]), notice: t('notice.delete_member', email: @grouping.user.email)
    else
      render template: "groups/show"
    end
  end

  
  private
  
  def email_exist? # すでにメンバー登録されている場合はグループ詳細画面に遷移する,リファクタリング（モデルに持っていく）
    set_group
    redirect_to group_path(@group.id), notice: t('notice.registered_as_a_member', email: params[:email]) if @group.members.exists?(email: params[:email])
  end
  
  def user_exist? # ユーザとして存在しない場合はグループ詳細画面に遷移する,リファクタリング（モデルに持っていく）
    set_group
    if !params[:email].present?
      redirect_to group_path(@group.id), notice: t('notice.email_blank')
    elsif !User.exists?(email: params[:email])
      redirect_to group_path(@group.id), notice: t('notice.no_email_create_an_account', email: params[:email])
    end
  end

  def grouping_admin_grant_or_release # 管理者権限の付与・解除時に表示されるtoticeの条件分岐
    if @grouping.admin
      redirect_to group_path(params[:group_id]), notice: t('notice.grant_admin_privilege', email: @grouping.user.email)
    else
      redirect_to group_path(params[:group_id]), notice: t('notice.release_admin_privilege', email: @grouping.user.email)
    end
  end

  def group_admin_members? # グループ管理者ではない場合、グループ詳細画面にリダイレクトする
    redirect_to group_path(params[:group_id]) unless group_admin?
  end

  def set_grouping
    @grouping = Grouping.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_groupings # グループに所属しているメンバー情報を取得している
    group = Group.find(params[:group_id])
    @groupings = group.groupings.includes(:user)
  end
end

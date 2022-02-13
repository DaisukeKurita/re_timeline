class GroupingsController < ApplicationController
  before_action :authenticate_user!

  def create
    email_exist? and return
    user_exist? and return
    group = find_group(params[:group_id])
    user = User.find_by(email: grouping_params) 
    if user
      group.groupings.create(user_id: user.id)
      redirect_to group_path(group.id), notice: t('notice.member_registration_completed', email: grouping_params)
    end
  end
  
  def destroy
    grouping = Grouping.find(params[:id])
    grouping.destroy
    redirect_to group_path(params[:group_id]), notice: t('notice.delete_member', email: grouping.user.email)
  end
  
  private
  
  def grouping_params
    params[:email]
  end
  
  # すでにメンバー登録されている場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def email_exist?
    group = find_group(params[:group_id])
    redirect_to group_path(group.id), notice: t('notice.registered_as_a_member', email: grouping_params) if group.members.exists?(email: grouping_params)
  end
  
  # ユーザとして存在しない場合はグループ詳細画面に遷移する
  # リファクタリング（モデルに持っていく）
  def user_exist?
    group = find_group(params[:group_id])
    if !grouping_params.present?
      redirect_to group_path(group.id), notice: t('notice.email_blank')
    elsif !User.exists?(email: grouping_params)
      redirect_to group_path(group.id), notice: t('notice.no_email_create_an_account', email: grouping_params)
    end
  end

  # Group.find(params[:group_id])の共通化
  def find_group(_group_id)
    Group.find(params[:group_id])
  end
end

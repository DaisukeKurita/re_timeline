class GroupingsController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group_id
  before_action :set_grouping, only: %i[update destroy]
  before_action :group_admin_members?, only: %i[create update destroy]

  def create
    @user = User.find_by(email: params[:email])
    user_exist? and return
    email_exist? and return
    if @user
      @group.groupings.create(user_id: @user.id)
      flash[:success] = t('notice.member_registration_completed', email: @user.email)
      redirect_to group_path(@group)
    else
      render template: "groups/show"
    end
  end

  def update
    if @grouping.update(admin: params[:admin])
      grouping_admin_grant_or_release
    else
      update_destroy_else_render
      render template: "groups/show"
    end
  end

  def destroy
    if @grouping.destroy
      flash[:danger] = t('notice.delete_member', email: @grouping.user.email)
      redirect_to group_path(@group)
    else
      update_destroy_else_render
      render template: "groups/show"
    end
  end

  private

  def email_exist?
    return unless @group.members.exists?(email: @user.email)

    flash[:warning] = t('notice.registered_as_a_member', email: @user.email)
    redirect_to group_path(@group)
  end

  def user_exist?
    if !params[:email].present?
      flash[:warning] = t('notice.email_blank')
      redirect_to group_path(@group)
    elsif !User.exists?(email: params[:email])
      flash[:warning] = t('notice.no_email_create_an_account', email: params[:email])
      redirect_to group_path(@group)
    end
  end

  def grouping_admin_grant_or_release
    if @grouping.admin
      flash[:success] = t('notice.grant_admin_privilege', email: @grouping.user.email)
    else
      flash[:danger] = t('notice.release_admin_privilege', email: @grouping.user.email)
    end
    redirect_to group_path(@group)
  end

  def group_admin_members?
    redirect_to group_path(@group) unless group_admin?
  end

  def set_grouping
    @grouping = Grouping.find(params[:id])
  end

  def update_destroy_else_render
    @groupings = @group.groupings.includes(:user)
    group_admin?
  end
end

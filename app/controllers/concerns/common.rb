module Common
  extend ActiveSupport::Concern

  def set_group_id
    @group = Group.find(params[:group_id])
  end

  def current_user_belong_to_groups?
    redirect_to groups_path unless current_user.groups.ids.include?(@group.id.to_i)
  end

  def group_admin?
    @group_admin = Grouping.find_by(user_id: current_user.id, group_id: @group.id).admin
  end
end

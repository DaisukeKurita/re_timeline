module Common
  extend ActiveSupport::Concern

  def set_group_id
    @group = Group.find(params[:group_id])
  end
end
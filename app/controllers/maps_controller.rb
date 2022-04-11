class MapsController < ApplicationController
  before_action :authenticate_user!
  include Common

  def index
    set_group_id
    current_user_belong_to_groups?
    gon.group_maps = Map.find(Blog.where(group_id: @group.id).ids)
  end
end

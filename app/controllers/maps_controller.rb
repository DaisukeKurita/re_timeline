class MapsController < ApplicationController
  before_action :authenticate_user!
  include Common

  def index
    set_group_id
    current_user_belong_to_groups?
    gon.group_maps = @group.maps.where.not(address: "")
  end
end

class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @groups = Group.select(:id, :name, :explanation)
  end
  
  def show
  end
  
  def new
    @group = Group.new
  end
  
  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to group_path(@group), notice: t('notice.group_created', name: @group.name)
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: t('notice.edited_the_group', name: @group.name)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: t('notice.deleted_the_group', name: @group.name)
  end

  private
    def group_params
      params.require(:group).permit(:name, :explanation)
    end

    def set_group
      @group = Group.find(params[:id])
    end
end

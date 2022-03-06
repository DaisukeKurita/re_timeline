class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :login_user_group?, only: %i[ show edit update destroy ]

  def index # ログインユーザーのみのグループ一覧を表示する
    @groups = current_user.groups
  end
  
  def show
    @groupings = @group.groupings.includes(:user)
  end
  
  def new
    @group = Group.new
  end
  
  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.groupings.create(user_id: current_user.id, admin: true)
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

  def login_user_group? # 所属していないグループにアクセスすると、グループ一覧にリダイレクトされる
    redirect_to groups_path unless current_user.groups.ids.include?(params[:id].to_i)
  end
end

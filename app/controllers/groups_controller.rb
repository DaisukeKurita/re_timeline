class GroupsController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :group_admin_only, only: %i[ edit update destroy ]
  before_action :current_user_belong_to_groups?, only: %i[ show edit update destroy ]

  def index
    # ログインユーザーのみのグループ一覧を表示する
    @groups = current_user.groups

    # ログインユーザーがグループ管理者のグループのidを抽出している
    @groupings_admin = current_user.groupings.where(admin: true).pluck(:group_id)
  end
  
  def show
    @groupings = @group.groupings.includes(:user)
    group_admin_or_general
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

  def group_admin_only # グループ管理者以外はグループ一覧に戻る
    redirect_to groups_path unless group_admin?
  end
end

class GroupsController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group, only: %i[ show edit update destroy delivery_setup delivery_period]
  before_action :group_admin_only, only: %i[ edit update destroy ]
  before_action :current_user_belong_to_groups?, only: %i[ show edit delivery_setup ]

  def index
    # ログインユーザーのみのグループ一覧を表示する
    @groups = current_user.groups

    # ログインユーザーがグループ管理者のグループのidを抽出している
    @groupings_admin = current_user.groupings.where(admin: true).pluck(:group_id)
  end
  
  def show
    @groupings = @group.groupings.includes(:user)
    group_admin?
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
      flash[:success] = t('notice.group_created', name: @group.name)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      flash[:info] = t('notice.edited_the_group', name: @group.name)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:danger] = t('notice.deleted_the_group', name: @group.name)
    redirect_to groups_path
  end

  def delivery_setup
    # 配信開始年の情報を取得
    today = Date.today
    @last_year = today.year - 1
    @one_hundred_years_ago = today.prev_year(100).year
    
    # @current_time = Time.now
    if last_friday_of_the_month(0) < @now
      last_friday_of_the_month(1)
      diary_delivery_range(1)
    else
      diary_delivery_range(0)
    end
  end

  def delivery_period
    @group.update(group_params)
    flash[:success] = t('notice.delivery_setup_complete')
    redirect_to delivery_setup_group_path(@group)
  end
  
  private
  def group_params
    params.require(:group).permit(:name, :explanation, :delivery_start_year, :receiving_date)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def group_admin_only # グループ管理者以外はグループ一覧に戻る
    redirect_to groups_path unless group_admin?
  end

  def last_friday_of_the_month(how_many_months)
    @now = Time.now
    relevant_date = @now.since(how_many_months.months)
    (0..6).each do |num|
      friday_check = relevant_date.end_of_month - num.days
      if friday_check.wday == 5
        return @last_friday = friday_check.beginning_of_day + 60 * 60 * 19
      end
    end
  end

  def diary_delivery_range(how_many_months)
    case @group.receiving_date 
    when "one_month_ago"
      diary_of_which_year_and_month(how_many_months, 1)
    when "two_months_ago"
      diary_of_which_year_and_month(how_many_months, 2)
    when "three_months_ago"
      diary_of_which_year_and_month(how_many_months, 3)
    end
  end

  def diary_of_which_year_and_month(how_many_months, how_many_months_ago)
    @start_year = @group.delivery_start_year.year
    @prev_year = @now.prev_year.year
    @months = @now.since((how_many_months + how_many_months_ago).months).mon
    
    # @delivery_range = "#{@group.delivery_start_year.year}年〜#{@now.prev_year.year}年間の#{@now.since((how_many_months + how_many_months_ago).months).mon}月の日記"
  end
end
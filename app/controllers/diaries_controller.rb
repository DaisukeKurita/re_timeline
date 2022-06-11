class DiariesController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group_id
  before_action :set_diary, only: %i[ show edit update destroy notice_switching ]
  before_action :current_user_belong_to_groups?
  before_action :group_admin?, only: %i[ index show ]
  before_action :diaries_new_contributor_or_group_admin?, only: %i[ edit ]
  
  def index
    @diaries = @group.diaries.includes(:new_contributor, :last_updater)
    @new_group_diary_contributor = Diary.find_by(new_contributor: current_user.id, group_id: @group.id).present?
  end

  def show
    lat_log_present?
    @groupings = @group.groupings
    @maps = @diary.maps
  end

  def new
    @diary = Diary.new
    @diary.maps.build
  end
  
  def edit
    lat_log_present?
  end

  def confirm
    @diary = @group.diaries.build(diary_params)
    @diary.new_contributor_id = current_user.id
    @maps = @diary.maps
    lat_log_present?
    num = 0
    @diary.maps.size.times do
      @diary.maps[num][:group_id] = @group.id
      num += 1
    end
    render :new if @diary.invalid?
  end
  
  def create
    @diary = @group.diaries.build(diary_params)
    lat_log_present?
    return render :new if params[:back]
    @diary.new_contributor_id = current_user.id
    num = 0
    @diary.maps.size.times do
      @diary.maps[num][:group_id] = @group.id
      num += 1
    end
    if @diary.save
      redirect_to group_diaries_path(@group), notice: t('notice.diary_created', diary_title: @diary.title)
    else
      render :new
    end
  end
  
  def update
    @diary.last_updater_id = current_user.id
    if @diary.update(diary_params)
      redirect_to group_diaries_path(@group), notice: t('notice.edited_the_diary', diary_title: @diary.title)
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to group_diaries_path(@group), notice: t('notice.deleted_the_diary', diary_title: @diary.title)
  end

  def notice_switching
    if @diary.update(email_notice: params[:email_notice])
      redirect_to group_diaries_path
    else
      render :index
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :event_date, :content, :photo, :photo_cache, :email_notice,
      maps_attributes: [:id, :address, :event_time, :group_id])
  end

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diaries_new_contributor_or_group_admin?
    redirect_to group_diaries_path(@group) unless current_user.id == @diary.new_contributor_id || group_admin?
  end

  def lat_log_present?
    search_addresses = @diary.maps.map(& :address)
    @search_addresses = search_addresses[0]
    if @search_addresses.present?
      gon.search_addresses = @search_addresses
      gon.lat = Geocoder.coordinates(@search_addresses)[0] 
      gon.lng = Geocoder.coordinates(@search_addresses)[1]
    end
  end
end

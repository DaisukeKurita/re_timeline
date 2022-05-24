class BlogsController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group_id
  before_action :set_blog, only: %i[ show edit update destroy notice_switching ]
  before_action :current_user_belong_to_groups?
  before_action :group_admin?, only: %i[ index show ]
  before_action :blogs_new_contributor_or_group_admin?, only: %i[ edit ]
  
  def index
    @blogs = @group.blogs.includes(:new_contributor, :last_updater)
    # グループ日記新規投稿者
    @new_group_diary_contributor = Blog.find_by(new_contributor: current_user.id, group_id: @group.id).present?
  end

  def show
    lat_log_present?
    @groupings = @group.groupings
    @maps = @blog.maps
  end

  def new
    @blog = Blog.new
    @blog.maps.build
  end
  
  def edit
    lat_log_present?
  end

  def confirm
    @blog = @group.blogs.build(blog_params)
    @blog.new_contributor_id = current_user.id
    @maps = @blog.maps
    lat_log_present?
    num = 0
    @blog.maps.size.times do
      @blog.maps[num][:group_id] = @group.id
      num += 1
    end
    render :new if @blog.invalid?
  end
  
  def create
    @blog = @group.blogs.build(blog_params)
    lat_log_present?
    return render :new if params[:back]
    @blog.new_contributor_id = current_user.id
    num = 0
    @blog.maps.size.times do
      @blog.maps[num][:group_id] = @group.id
      num += 1
    end
    if @blog.save
      redirect_to group_blogs_path(@group), notice: t('notice.blog_created', blog_title: @blog.title)
    else
      render :new
    end
  end
  
  def update
    @blog.last_updater_id = current_user.id
    if @blog.update(blog_params)
      redirect_to group_blogs_path(@group), notice: t('notice.edited_the_blog', blog_title: @blog.title)
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to group_blogs_path(@group), notice: t('notice.deleted_the_blog', blog_title: @blog.title)
  end

  def notice_switching
    if @blog.update(email_notice: params[:email_notice])
      redirect_to group_blogs_path
    else
      render :index
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :event_date, :content, :photo, :photo_cache, :email_notice,
      maps_attributes: [:id, :address, :event_time, :group_id])
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blogs_new_contributor_or_group_admin?  # ブログの新規投稿者かグループの管理者でない場合はブログ一覧に返す
    redirect_to group_blogs_path(@group) unless current_user.id == @blog.new_contributor_id || group_admin?
  end

  def lat_log_present? #緯度・経度の値が存在するか？ 複数検索にも対応できるようにする。
    search_addresses = @blog.maps.map(& :address)
    @search_addresses = search_addresses[0]
    if @search_addresses.present?
      gon.search_addresses = @search_addresses
      gon.lat = Geocoder.coordinates(@search_addresses)[0] 
      gon.lng = Geocoder.coordinates(@search_addresses)[1]
    end
  end
end

class BlogsController < ApplicationController
  before_action :authenticate_user!
  include Common
  before_action :set_group_id
  before_action :set_blog, only: %i[ show edit update destroy notice_switching ]
  before_action :current_user_belong_to_groups?
  before_action :group_admin?, only: %i[ index show ]
  before_action :blogs_new_contributor_or_group_admin?, only: %i[ edit update destroy ]
  
  def index
    @blogs = @group.blogs.includes(:new_contributor, :last_updater)
  end

  def show
    @groupings = @group.groupings
  end

  def new
    @blog = Blog.new
    gon.blog = @blog
  end
  
  def edit
    gon.blog = @blog
    lat_log_presetn?
  end

  def confirm
    @blog = Blog.new(blog_params)
    lat_log_presetn?
  end
  
  def create
    @blog = @group.blogs.build(blog_params)
    gon.blog = @blog
    return render :new if params[:back]
    @blog.new_contributor_id = current_user.id
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
    params.require(:blog).permit(:title, :event_date, :content, :photo, :photo_cache, :email_notice, :address)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blogs_new_contributor_or_group_admin?  # ブログの新規投稿者かグループの管理者でない場合はブログ一覧に返す
    redirect_to group_blogs_path(@group) unless current_user.id == @blog.new_contributor_id || group_admin?
  end

  def lat_log_presetn? #緯度・経度の値が存在するか？
    if @blog.address.present?
      gon.lat = Geocoder.coordinates(@blog.address)[0] 
      gon.lng = Geocoder.coordinates(@blog.address)[1]
    end
  end
end

class BlogsController < ApplicationController
  before_action :login_user_group_blog?
  before_action :blogs_new_contributor_or_group_admin?, only: %i[ edit update destroy ]
  before_action :set_group_id
  before_action :set_blog, only: %i[ show edit update destroy ]
  
  def index
    @blogs = @group.blogs.includes(:new_contributor, :last_updater)
    @groupings = @group.groupings
  end

  def show
    @groupings = @group.groupings
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def confirm
    @blog = Blog.new(blog_params)
  end
  
  def create
    @blog = @group.blogs.build(blog_params)
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
      rednder :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to group_blogs_path(@group), notice: t('notice.deleted_the_blog', blog_title: @blog.title)
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content)
  end

  def set_group_id
    @group = Group.find(params[:group_id])
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  # 所属していないグループのブログにアクセスすると、グループ一覧にリダイレクトされる
  def login_user_group_blog?
    redirect_to groups_path unless current_user.groups.ids.include?(params[:group_id].to_i)
  end

  # ブログの新規投稿者かグループの管理者か判定をしている
  def blogs_new_contributor_or_group_admin?
    set_group_id
    set_blog
    @groupings = @group.groupings
    redirect_to group_blogs_path(@group) unless current_user.id == @blog.new_contributor_id || group_admin?
  end
end

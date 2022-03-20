module BlogsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_group_blogs_path(@group)
    elsif action_name == 'edit'
      group_blog_path(@group)
    end
  end
end
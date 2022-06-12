module DiariesHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_group_diaries_path(@group)
    elsif action_name == 'edit'
      group_diary_path(@group)
    end
  end
end
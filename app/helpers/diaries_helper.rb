module DiariesHelper
  def choose_new_or_edit
    case action_name
    when action_name == 'new' || action_name == 'create' || action_name == 'confirm'
      confirm_group_diaries_path(@group)
    when action_name == 'edit'
      group_diary_path(@group)
    end
  end
end

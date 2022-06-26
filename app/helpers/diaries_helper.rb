module DiariesHelper
  def choose_new_or_edit
    case action_name
    when 'new', 'create', 'confirm'
      confirm_group_diaries_path(@group)
    when 'edit'
      group_diary_path(@group)
    end
  end
end

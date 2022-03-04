module GroupingsHelper
  def group_admin?
    @groupings.try!(:each) do |grouping|
      return true if grouping.admin == true && current_user == grouping.user
    end
    false
  end
end
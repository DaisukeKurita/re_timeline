module GroupingsHelper
  def group_admin?
    @groupings.try!(:each) do |grouping|
      return unless grouping.admin == true && current_user == grouping.user
    end
  end
end
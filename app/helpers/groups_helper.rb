module GroupsHelper
  def group_admin?
    return unless @groupings.present?
    @groupings.each do |grouping|
      next unless current_user == grouping.user
      return unless grouping.admin == true
    end # returnでしっかり切らないとnilが返ってっいる
  end
end
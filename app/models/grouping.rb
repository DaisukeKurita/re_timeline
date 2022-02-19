class Grouping < ApplicationRecord
  belongs_to :user
  belongs_to :group
  before_destroy :zero_admin_cannot

  private
  def zero_admin_cannot
    errors.add(:admin, :zero_admin_cannot)
    throw(:abort) if Grouping.where(group_id: self.group_id, admin:true).length == 1 && self.admin?
  end
end

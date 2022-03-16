class Grouping < ApplicationRecord
  belongs_to :user
  belongs_to :group
  before_destroy :zero_admin_cannot
  before_update :admin_update_exist
  has_many :new_contributor_blogs, foreign_key: :new_contributor_id, class_name: 'Blog'
  has_many :last_updater_blogs, foreign_key: :last_updater_id, class_name: 'Blog'

  private
  def zero_admin_cannot
    return if destroyed_by_association.present?
    errors.add(:admin, :zero_admin_cannot)
    throw(:abort) if Grouping.where(group_id: self.group_id, admin: true).length == 1 && self.admin?
  end

  def admin_update_exist
    errors.add(:admin, :zero_admin_cannot)
    return unless Grouping.where(group_id: self.group_id, admin: true).length == 1
    return unless Grouping.where(group_id: self.group_id, admin: true).first.id == self.id
    return unless self.admin? == false
    throw(:abort)
  end
end

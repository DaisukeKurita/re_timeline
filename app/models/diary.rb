class Diary < ApplicationRecord
  validates :title, presence: :true, length: { maximum: 255}
  belongs_to :new_contributor, foreign_key: :new_contributor_id, class_name: 'User'
  belongs_to :last_updater, foreign_key: :last_updater_id, optional: true, class_name: 'User'
  belongs_to :group
  mount_uploader :photo, PhotoUploader
  has_many :maps, dependent: :destroy
  accepts_nested_attributes_for :maps, allow_destroy: true
end

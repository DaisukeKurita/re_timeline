class Blog < ApplicationRecord
  validates :title, presence: :true, length: { maximum: 255}
  belongs_to :new_contributor, foreign_key: :new_contributor_id, class_name: 'User'
  belongs_to :last_updater, foreign_key: :last_updater_id, optional: true, class_name: 'User'
  belongs_to :group
  mount_uploader :photo, PhotoUploader
  has_many :blogmaps, dependent: :destroy
  has_many :blog_maps, through: :blogmaps, source: :map
  geocoded_by :address
  after_validation :geocode
  # acceptes_nested_attributes_for :blogmaps, allow_destroy: true, reject_if: :all_blank
end

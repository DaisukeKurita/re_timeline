class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  has_many :groupings, dependent: :destroy
  has_many :members, through: :groupings, source: :user
  has_many :blogs, dependent: :destroy
  has_many :maps
end

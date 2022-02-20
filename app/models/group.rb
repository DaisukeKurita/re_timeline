class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  has_many :groupings, dependent: :destroy, validate: false
  has_many :members, through: :groupings, source: :user
end

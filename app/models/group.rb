class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  has_many :groupings, dependent: :destroy
  has_many :members, through: :groupings, source: :user
  has_many :blogs, dependent: :destroy
  has_many :maps, dependent: :destroy

  enum receiving_date: { no_notice: 0, one_month_ago: 1, two_months_ago: 2, three_months_ago: 3 }
end

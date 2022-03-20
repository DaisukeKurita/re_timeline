class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, length: { maximum: 255 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groupings, dependent: :destroy
  has_many :groups, through: :groupings
  has_many :new_contributor_blogs, foreign_key: :new_contributor_id, class_name: 'Blog'
  has_many :last_updater_blogs, foreign_key: :last_updater_id, class_name: 'Blog'
end

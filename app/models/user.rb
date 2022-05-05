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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.admin_guest
    find_or_create_by!(email: 'admin_guest@example.com') do |user|
      user.name = 'admin_guest'
      user.admin = true
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

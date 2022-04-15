class Group < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  has_many :groupings, dependent: :destroy
  has_many :members, through: :groupings, source: :user
  has_many :blogs, dependent: :destroy
  has_many :maps, dependent: :destroy

  enum receiving_date: { no_notice: 0, one_month_ago: 1, two_month_ago: 2, three_months_ago: 3 }
  
  def self.email_sending_settings
    today = Date.today
    one_week_later = today + 7
    # return if today.mon == one_week_later.mon
    case self.receiving_dates
    when 1
      puts "a"
    when 2
      puts "b"
    when 3
      puts "c"
    else
      puts "d"
    end 
    binding.pry
  end
end

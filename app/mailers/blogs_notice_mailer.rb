class BlogsNoticeMailer < ApplicationMailer
  before_action :email_sending_settings, only: %i[ blogs_notice_mail ]

  def blogs_notice_mail(group, blogs, blogs_month)
    @group = group
    @blogs = blogs
    @blogs_month = blogs_month
    # mail(to: @group.members.pluck(:email), subject: default_i18n_subject(group: @group.name))
    mail to: @group.members.pluck(:email), subject: "#{@group.name}の過去の#{@blogs_month}月のブログをお知らせします！"
  end

  private

  # 月内の最終金曜日かを判断後、メールを送る内容を取得
  def email_sending_settings
    today = Date.today
    one_week_later = today + 7
    return if today.mon == one_week_later.mon
    groups = Group.all
    groups.each do |group|
      case group.receiving_date 
      when "one_month_ago"
        blog_search_by_year_and_month(1, group, today)
      when "two_months_ago"
        blog_search_by_year_and_month(2, group, today)
      when "three_months_ago"
        blog_search_by_year_and_month(3, group, today)
      end
    end
  end
  
  # blogsテーブルから数年分の指定月のレコードを取得するメソッド
  def blog_search_by_year_and_month(how_many_months, group, today)
    many_years_ago = today.year - group.delivery_start_year.year
    months_by_year = []
    for num in 1..many_years_ago do  
      months_by_year << today.ago(num.years).since(how_many_months.month).all_month
    end
    blogs = group.blogs.where(email_notice: true, event_date: months_by_year).order(event_date: "DESC")
    blogs_month = today.since(how_many_months.month).mon
    blogs_notice_mail(group, blogs, blogs_month).deliver
  end
end

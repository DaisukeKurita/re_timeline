class BlogsNoticeMailer < ApplicationMailer

  def sending_mail(group, blogs)
    @group = group
    @blogs = blogs
    mail to: @group.members.pluck(:email), subject: "#{@group.name}の過去のブログをお知らせします！"
  end

  def mail_config
    @today = Date.today
    one_week_later = @today + 7
    # return if today.mon == one_week_later.mon

    # -------------- email_sending_settings--------------
    groups = Group.all
    groups.each do |group|
      @group = group
      case group.receiving_date 
      when "one_month_ago"
        # binding.pry
        blog_search_by_year_and_month(1, @today)
        # sending_mail(@group, @blogs).deliver
      when "two_months_ago"
        # binding.pry
        blog_search_by_year_and_month(2, @today)
        # sending_mail(@group, @blogs).deliver
      when "three_months_ago"
        # binding.pry
        blog_search_by_year_and_month(3, @today)
        # sending_mail(@group, @blogs).deliver
      else
        binding.pry
        next
      end
      mail to: @group.members.pluck(:email), subject: "#{@group.name}の過去のブログをお知らせします！"
    end
  end

  # def sending_mail
  #   @today = Date.today
  #   one_week_later = @today + 7
  #   binding.pry
  #   # return if today.mon == one_week_later.mon
  #   blogs_notice_mail.deliver
  # end 

  def blogs_notice_mail
    email_sending_settings
    binding.pry
    mail to: @group.members.pluck(:email), subject: "#{@group.name}の過去のブログをお知らせします！"
  end

private

# 月内の最終金曜日かを判断後、メールを送る内容を取得
  # ヘルパーに移す
  # def email_sending_settings
  #   groups = Group.all
  #   groups.each do |group|
  #     @group = group
  #     case group.receiving_date 
  #     when "one_month_ago"
  #       blog_search_by_year_and_month(1, @today)
  #     when "two_months_ago"
  #       blog_search_by_year_and_month(2, @today)
  #     when "three_months_ago"
  #       blog_search_by_year_and_month(3, @today)
  #     else
  #       next
  #     end
  #   end 
  #   # exit
  # end
  
  # blogsテーブルから数年分の指定月のレコードを取得するメソッド
  # ヘルパーに移す
  def blog_search_by_year_and_month(how_many_months, today)
    many_years_ago = today.year - @group.delivery_start_year.year
    months_by_year = []
    for num in 1..many_years_ago do  
      months_by_year << today.ago(num.years).since(how_many_months.month).all_month
    end
    @blogs = @group.blogs.where(email_notice: true, event_date: months_by_year)
    # @blogs_month = today.since(how_many_months.month).mon
    # binding.pry
    # @msg = @blogs_month.to_s + "月にはこんなことがあったよ!"
  end
end

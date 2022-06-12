namespace :scheduled_delivery do
  desc '月の最終金曜日だった時、設定されている月の過去のグループ日記情報を取得し、メールを配信'
  task email_scheduled_delivery: :environment do
    def diary_search_by_year_and_month(how_many_months, group, today)
      many_years_ago = today.year - group.delivery_start_year.year
      months_by_year = []
      for num in 1..many_years_ago do  
        months_by_year << today.ago(num.years).since(how_many_months.month).all_month
      end
      diaries = group.diaries.where(email_notice: true, event_date: months_by_year).order(event_date: "DESC")
      diaries_month = today.since(how_many_months.month).mon
      DiariesNoticeMailer.diaries_notice_mail(group, diaries, diaries_month).deliver
    end

    today = Date.today
    one_week_later = today + 7
    exit if today.mon == one_week_later.mon
    groups = Group.all
    groups.each do |group|
      case group.receiving_date
      when "one_month_ago"
        diary_search_by_year_and_month(1, group, today)
      when "two_months_ago"
        diary_search_by_year_and_month(2, group, today)
      when "three_months_ago"
        diary_search_by_year_and_month(3, group, today)
      end
    end
  end
end

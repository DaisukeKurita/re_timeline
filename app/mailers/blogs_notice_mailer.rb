class BlogsNoticeMailer < ApplicationMailer
  def blogs_notice_mail(group, blogs, blogs_month)
    @group = group
    @blogs = blogs
    @blogs_month = blogs_month
    # mail(to: @group.members.pluck(:email), subject: default_i18n_subject(group: @group.name))
    mail to: @group.members.pluck(:email), subject: "#{@group.name}の過去の#{@blogs_month}月のブログをお知らせします！"
  end
end

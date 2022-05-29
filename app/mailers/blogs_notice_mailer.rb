class BlogsNoticeMailer < ApplicationMailer
  def blogs_notice_mail(group, blogs, blogs_month)
    @group = group
    @blogs = blogs
    @blogs_month = blogs_month
    # mail(to: @group.members.pluck(:email), subject: default_i18n_subject(group: @group.name))
    mail to: @group.members.pluck(:email), subject: default_i18n_subject(group_name: @group.name, blogs_month: @blogs_month)
  end
end

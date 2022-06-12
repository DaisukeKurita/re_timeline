class DiariesNoticeMailer < ApplicationMailer
  def diaries_notice_mail(group, diaries, diaries_month)
    @group = group
    @diaries = diaries
    @diaries_month = diaries_month
    mail to: @group.members.pluck(:email), subject: default_i18n_subject(group_name: @group.name, diaries_month: @diaries_month)
  end
end

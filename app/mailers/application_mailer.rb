class ApplicationMailer < ActionMailer::Base
  default 'Content-Transfer-Encoding' => '8bit'
  default from: 'a.p.l.daikons.msn36@gmail.com'
  layout 'mailer'
end

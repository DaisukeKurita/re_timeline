class ApplicationMailer < ActionMailer::Base
  default 'Content-Transfer-Encoding' => '8bit'
  default from: 'daikons.msn36@gmail.com'
  layout 'mailer'
end

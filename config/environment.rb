# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'], 
  :password => ENV['SENDGRID_PASSWORD'], 
  :domain => 'ec2-35-78-10-205.ap-northeast-1.compute.amazonaws.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
env :PATH, ENV['PATH']
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every :friday, at: '7pm' do
  rake 'scheduled_delivery:email_scheduled_delivery'
end

every 1.minute do
  rake 'scheduled_delivery:email_scheduled_delivery'
end
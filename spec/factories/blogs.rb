FactoryBot.define do
  factory :blog do
    last_updater_id { nil }
    title { "title1" }
    content { "content1" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg')) }
    event_date { "2022-03-15" }
    email_notice { false }
    association :new_contributor, factory: :user
    association :group
  end

  factory :blog2, class: Blog  do
    last_updater_id { nil }
    title { "title2" }
    content { "content2" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg')) }
    event_date { "2022-04-28" }
    email_notice { false }
    association :new_contributor, factory: :user
    association :group
  end

  factory :blog3, class: Blog  do
    new_contributor_id { nil }
    last_updater_id { nil }
    title { "title3" }
    content { "content3" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg')) }
    event_date { "2015-12-28" }
    email_notice { false }
    association :new_contributor, factory: :user2
    association :group2
  end

  factory :blog4, class: Blog  do
    new_contributor_id { nil }
    last_updater_id { nil }
    title { "title4" }
    content { "content4" }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg')) }
    event_date { "2016-10-13" }
    email_notice { false }
    association :new_contributor, factory: :user2
    association :group2
  end
end

FactoryBot.define do
  factory :blog do
    new_contributor_id { 1 }
    last_updater_id { 1 }
    title { "MyString" }
    content { "MyText" }
    image { "MyText" }
    event_date { "2022-03-15 05:43:01" }
    notice { false }
  end
end

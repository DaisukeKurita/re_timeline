FactoryBot.define do
  factory :map do
    address { "沼津駅" }
    latitude { 35.1026494 }
    longitude { 138.8598006 }
    event_time { "2000-01-01 13:00:00" }
    association :diary
    association :group
  end

  factory :map2, class: Map do
    address { "偕楽園" }
    latitude { 36.37262630000001 }
    longitude { 140.4521765 }
    event_time { "2000-01-01 11:40:00" }
    association :diary
    association :group
  end

  factory :map3, class: Map do
    address { "ユニバーサルスタジオ" }
    latitude { 34.665442 }
    longitude { 135.4323382 }
    event_time { "2000-01-01 10:30:00" }
    association :diary2
    association :group2
  end

  factory :map4, class: Map do
    address { "草津温泉湯畑" }
    latitude { 36.6229647 }
    longitude { 138.5967231 }
    event_time { "2000-01-01 15:00:00" }
    association :diary2
    association :group2
  end
end

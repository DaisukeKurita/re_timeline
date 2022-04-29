FactoryBot.define do
  factory :group do
    name { 'group1' }
    explanation { 'aaaaa' }
    delivery_start_year { 'nil' }
    receiving_date { 'no_notice' }
  end

  factory :group2, class: Group do
    name { 'group2' }
    explanation { 'bbbbb' }
    delivery_start_year { 'nil' }
    receiving_date { 'no_notice' }
  end

  factory :group3, class: Group do
    name { 'group3' }
    explanation { 'ccccc' }
    delivery_start_year { 'nil' }
    receiving_date { 'no_notice' }
  end

  factory :group4, class: Group do
    name { 'group4' }
    explanation { 'ddddd' }
    delivery_start_year { 'nil' }
    receiving_date { 'no_notice' }
  end

  factory :group5, class: Group do
    name { 'group5' }
    explanation { 'eeeee' }
    delivery_start_year { 'nil' }
    receiving_date { 'no_notice' }
  end
end

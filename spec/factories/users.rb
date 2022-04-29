FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user1@gmail.com' }
    password { '111111' }
    admin { 'false' }
  end

  factory :user2, class: User do
    name { 'user2' }
    email { 'user2@gmail.com' }
    password { '111111' }
    admin { 'false' }
  end

  factory :user3, class: User do
    name { 'user3' }
    email { 'user3@gmail.com' }
    password { '111111' }
    admin { 'false' }
  end

  factory :user4, class: User do
    name { 'user4' }
    email { 'user4@gmail.com' }
    password { '111111' }
    admin { 'false' }
  end

  factory :admin_user, class: User do
    name { 'user5' }
    email { 'user5@gmail.com' }
    password { '111111' }
    admin { 'true' }
  end
end

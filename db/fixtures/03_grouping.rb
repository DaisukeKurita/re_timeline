# ぽむすけ家グルーピング------------------------------------------
Grouping.seed do |s|
  s.id = 1
  s.user_id = 1
  s.group_id = 1
  s.admin = true
end

Grouping.seed do |s|
  s.id = 2
  s.user_id = 2
  s.group_id = 1
  s.admin = false
end

Grouping.seed do |s|
  s.id = 3
  s.user_id = 3
  s.group_id = 1
  s.admin = false
end

Grouping.seed do |s|
  s.id = 4
  s.user_id = 4
  s.group_id = 1
  s.admin = false
end

Grouping.seed do |s|
  s.id = 5
  s.user_id = 5
  s.group_id = 1
  s.admin = false
end

# Tのキャンプグルーピング------------------------------------------
Grouping.seed do |s|
  s.id = 6
  s.user_id = 6
  s.group_id = 2
  s.admin = true
end

Grouping.seed do |s|
  s.id = 7
  s.user_id = 7
  s.group_id = 2
  s.admin = false
end

Grouping.seed do |s|
  s.id = 8
  s.user_id = 8
  s.group_id = 2
  s.admin = false
end

Grouping.seed do |s|
  s.id = 9
  s.user_id = 9
  s.group_id = 2
  s.admin = false
end

Grouping.seed do |s|
  s.id = 10
  s.user_id = 1
  s.group_id = 2
  s.admin = false
end

# S不定期麻雀2019グルーピング------------------------------------------
Grouping.seed do |s|
  s.id = 11
  s.user_id = 10
  s.group_id = 3
  s.admin = true
end

Grouping.seed do |s|
  s.id = 12
  s.user_id = 11
  s.group_id = 3
  s.admin = false
end

Grouping.seed do |s|
  s.id = 13
  s.user_id = 12
  s.group_id = 3
  s.admin = false
end

Grouping.seed do |s|
  s.id = 14
  s.user_id = 1
  s.group_id = 3
  s.admin = false
end

# 2020年卒業・M中学校バドミントングルーピング------------------------
Grouping.seed do |s|
  s.id = 15
  s.user_id = 3
  s.group_id = 4
  s.admin = true
end

# T地区行事まとめグルーピング------------------------------------------
Grouping.seed do |s|
  s.id = 16
  s.user_id = 2
  s.group_id = 5
  s.admin = true
end

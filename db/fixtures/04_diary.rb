Diary.seed do |s|
  s.id = 1
  s.new_contributor_id = 1
  s.last_updater_id = nil
  s.title = '新潟観光🙌'
  s.content = '新潟に観光に行った、下道で行くと7時間かかった。生まれて初めて、日本海をみた✨'
  s.photo = Rails.root.join("db/fixtures/images/niigata_umi.png").open
  s.event_date = "2022-04-29"
  s.email_notice = true
  s.group_id = 1
end

Diary.seed do |s|
  s.id = 2
  s.new_contributor_id = 2
  s.last_updater_id = nil
  s.title = 'パンダ🐼を見に和歌山へ'
  s.content = 'ずっときてみたかった、パンダの動物園。可愛いパンダを見る事ができ大満足😊'
  s.photo = Rails.root.join("db/fixtures/images/panda.png").open
  s.event_date = "2020-07-25"
  s.email_notice = true
  s.group_id = 1
end

Diary.seed do |s|
  s.id = 3
  s.new_contributor_id = 1
  s.last_updater_id = nil
  s.title = '大阪の遊園地🎢'
  s.content = '強硬突破で１泊２日で大阪の遊園地へ、子供たちも楽しそうで良かった🤩'
  s.photo = Rails.root.join("db/fixtures/images/yuenchi.png").open
  s.event_date = "2018-11-17"
  s.email_notice = true
  s.group_id = 1
end

Diary.seed do |s|
  s.id = 4
  s.new_contributor_id = 6
  s.last_updater_id = nil
  s.title = '那須高原でキャンプ⛺️'
  s.content = '数年ぶりのキャンプ、キムチうどんを作って食べた🍜夜はキャンプファイヤーをした🔥'
  s.photo = Rails.root.join("db/fixtures/images/nasu.png").open
  s.event_date = "2019-05-04"
  s.email_notice = true
  s.group_id = 2
end

Diary.seed do |s|
  s.id = 5
  s.new_contributor_id = 6
  s.last_updater_id = nil
  s.title = '尾瀬ハイキング🚶‍♀️＋キャンプ'
  s.content = '歩き疲れた...、けど一度来てみかったので良かった😁今回の参加者は4名。'
  s.photo = Rails.root.join("db/fixtures/images/oze.png").open
  s.event_date = "2016-08-13"
  s.email_notice = true
  s.group_id = 2
end

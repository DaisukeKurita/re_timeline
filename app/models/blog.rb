class Blog < ApplicationRecord
  belongs_to :new_contributor, foreign_key: :new_contributor_id, class_name: 'Grouping'
  belongs_to :last_updater, foreign_key: :last_updater_id, class_name: 'Grouping'
end

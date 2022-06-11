class Map < ApplicationRecord
  belongs_to :diary
  belongs_to :group
  geocoded_by :address
  after_validation :geocode
end

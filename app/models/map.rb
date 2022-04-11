class Map < ApplicationRecord
  belongs_to :blog
  belongs_to :group
  geocoded_by :address
  after_validation :geocode
end

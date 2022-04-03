class Map < ApplicationRecord
  has_many :blogmaps
  has_many :map_blogs, through: :blogmaps, source: :blog
  # geocoded_by :address
  # after_validation :geocode
end

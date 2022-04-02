class Map < ApplicationRecord
  has_many :blogmaps
  has_many :map_blogs, through: :blogmaps, source: :blog
end

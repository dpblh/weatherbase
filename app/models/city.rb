class City < ActiveRecord::Base
  include TranslateScope

  belongs_to :part_place, polymorphic: true
  has_many :property_positions
end

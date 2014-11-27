class State < ActiveRecord::Base
  include TranslateScope

  belongs_to :country
  has_many :cities, as: :part_place
end

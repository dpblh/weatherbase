class Country < ActiveRecord::Base
  include TranslateScope

  has_many :cities, as: :part_place
  has_many :states

  validates :name, presence: true

end

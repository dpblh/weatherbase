class Category < ActiveRecord::Base
  include TranslateScope

  has_many :property_names
end

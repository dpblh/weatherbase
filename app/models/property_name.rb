class PropertyName < ActiveRecord::Base
  include TranslateScope

  belongs_to :category
  belongs_to :dimension
end

class PropertyPosition < ActiveRecord::Base
  belongs_to :city
  belongs_to :property_name
end

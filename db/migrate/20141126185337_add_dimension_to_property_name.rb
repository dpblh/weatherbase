class AddDimensionToPropertyName < ActiveRecord::Migration
  def change
    add_column :property_names, :dimension, :string
  end
end

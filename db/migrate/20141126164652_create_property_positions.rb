class CreatePropertyPositions < ActiveRecord::Migration
  def change
    create_table :property_positions do |t|

      t.string :values

      t.belongs_to :city, index: true
      t.belongs_to :property_name, index: true

      t.timestamps
    end
  end
end

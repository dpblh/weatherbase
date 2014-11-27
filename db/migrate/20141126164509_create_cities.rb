class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|

      t.string :name, index: true
      t.string :rus_name, index: true
      t.boolean :translate, default: false

      t.references :part_place, polymorphic: true, index: true
      t.timestamps
    end
  end
end

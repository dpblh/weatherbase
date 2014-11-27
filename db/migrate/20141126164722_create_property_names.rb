class CreatePropertyNames < ActiveRecord::Migration
  def change
    create_table :property_names do |t|

      t.string :name, index: true
      t.string :rus_name, index: true
      t.boolean :translate, default: false

      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end

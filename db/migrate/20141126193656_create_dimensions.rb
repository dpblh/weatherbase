class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|

      t.string :name
      t.string :rus_name
      t.boolean :translate, default: false

      t.timestamps
    end

    remove_column :property_names, :dimension
    add_belongs_to :property_names, :dimension

  end
end

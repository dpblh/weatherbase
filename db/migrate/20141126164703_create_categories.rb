class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name
      t.string :rus_name
      t.boolean :translate, default: false

      t.timestamps
    end
  end
end

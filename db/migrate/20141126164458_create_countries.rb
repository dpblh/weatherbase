class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|

      t.string :name
      t.string :rus_name
      t.boolean :translate, default: false

      t.timestamps
    end
  end
end

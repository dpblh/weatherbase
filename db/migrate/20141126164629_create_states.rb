class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|

      t.string :name
      t.string :rus_name
      t.boolean :translate, default: false

      t.belongs_to :country, index: true

      t.timestamps
    end
  end
end

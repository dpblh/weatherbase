class AddHrefToCityAndState < ActiveRecord::Migration
  def change
    add_column :cities, :href, :string, index: true
    add_column :states, :href, :string, index: true
  end
end

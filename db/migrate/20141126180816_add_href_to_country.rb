class AddHrefToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :href, :string, index: true
  end
end

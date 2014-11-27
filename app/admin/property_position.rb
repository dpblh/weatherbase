ActiveAdmin.register PropertyPosition do

  permit_params :values, :property_name_id, :city_id

  filter :property_name

  index do

    column :values
    column :dimension do |property_position|
      property_position.property_name.dimension.rus_name ? property_position.property_name.dimension.rus_name : property_position.property_name.dimension.name
    end
    column :name do |property_position|
      property_position.property_name.rus_name ? property_position.property_name.rus_name : property_position.property_name.name
    end
    column :city do |property_position|
      property_position.city.rus_name ? property_position.city.rus_name : property_position.city.name
    end
    column :category do |property_position|
      property_position.property_name.category.rus_name ? property_position.property_name.category.rus_name : property_position.property_name.category.name
    end
    actions

  end

  controller do
    def scoped_collection
      resource_class.includes(:city, property_name: [:dimension, :category])
    end
  end

end

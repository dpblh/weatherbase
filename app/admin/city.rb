ActiveAdmin.register City do

  menu parent: 'Directory'

  permit_params :name, :rus_name, :translate, :country_id

  config.sort_order = 'name_asc'

  filter :name
  filter :rus_name

  batch_action :destroy, false

  scope :translate
  scope :untranslate


  index do

    column :translate
    column :name, sortable: true
    column :rus_name, sortable: true
    column :translater do |city|
      text_field_tag city.id, '', class: :translater
    end
    actions

  end

  # Контроллер перевода
  member_action :translate, method: :put do
    head :fault and return if params[:translate].blank?
    city = City.find(params[:id])
    city.rus_name = params[:translate]
    city.translate = true
    city.save

    render json: city
  end

end

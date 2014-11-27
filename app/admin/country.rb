ActiveAdmin.register Country do

  menu parent: 'Directory'

  permit_params :name, :rus_name, :translate

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
    column :translater do |country|
      text_field_tag country.id, '', class: :translater
    end
    actions

  end

  # Контроллер перевода
  member_action :translate, method: :put do
    head :fault and return if params[:translate].blank?
    country = Country.find(params[:id])
    country.rus_name = params[:translate]
    country.translate = true
    country.save

    render json: country
  end

end

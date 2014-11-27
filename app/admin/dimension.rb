ActiveAdmin.register Dimension do

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
    column :translater do |dimension|
      text_field_tag dimension.id, '', class: :translater
    end
    actions

  end

  # Контроллер перевода
  member_action :translate, method: :put do
    head :fault and return if params[:translate].blank?
    dimension = Dimension.find(params[:id])
    dimension.rus_name = params[:translate]
    dimension.translate = true
    dimension.save

    render json: dimension
  end

end

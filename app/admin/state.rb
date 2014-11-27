ActiveAdmin.register State do

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
    column :translater do |state|
      text_field_tag state.id, '', class: :translater
    end
    actions

  end

  # Контроллер перевода
  member_action :translate, method: :put do
    head :fault and return if params[:translate].blank?
    state = State.find(params[:id])
    state.rus_name = params[:translate]
    state.translate = true
    state.save

    render json: state
  end

end

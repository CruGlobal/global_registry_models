class Entities::EntitiesController < BaseController

  before_action :load_entity_class

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entities = @entity_class.search page: @page, per_page: @per, filters: params[:filters]
    puts @entities.to_json
    render '/entities/entity_types' if entity_type?
  end

  def show
    @entity = @entity_class.find(params[:id])
  end

  private

    def load_entity_class
      @entity_class = "GlobalRegistryModels::Entity::#{ params[:entity_class_name].singularize.classify }".safe_constantize
      puts @entity_class
      redirect_to root_path if @entity_class.blank?
    end

    def entity_type?
      params[:page]=='EntityTypes'
    end

end


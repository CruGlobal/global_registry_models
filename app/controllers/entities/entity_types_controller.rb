class Entities::EntitiesController < BaseController

  before_action :load_entity_class

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entities = GlobalRegistryModels::Entity::EntityType.search page: @page, per_page: @per, filters: params[:filters]
  end

  def show
    @entity = @entity_class.find(params[:id])
  end

end


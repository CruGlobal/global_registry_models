class EntityTypesController < BaseController

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entity_type_class = GlobalRegistryModels::EntityType::EntityType
    @entity_types = @entity_type_class.search page: @page, per_page: @per
    @relationship_type_class = GlobalRegistryModels::RelationshipType::RelationshipType
    @relationship_types = @relationship_type_class.search
  end

  def show
    #@entity_type = GlobalRegistryModels::EntityType::EntityType.find(params[:id])
  end

end


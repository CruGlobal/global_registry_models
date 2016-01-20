class EntityTypesController < BaseController

  def index
    @entity_types = GlobalRegistryModels::EntityType::EntityType.search
  end

  def show
    #@entity = GlobalRegistryModels::Entity::EntityType.find(params[:id])
  end

end


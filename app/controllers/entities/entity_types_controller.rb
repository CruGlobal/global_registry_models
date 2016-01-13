class Entities::EntityTypesController < BaseController

  def index
    @entitiy_types = GlobalRegistryModels::Entity::EntityType.search
  end

  def show
    @entity = GlobalRegistryModels::Entity::EntityType.find(params[:id])
  end

end


class EntityTypesController < BaseController

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entity_types = GlobalRegistryModels::EntityType::EntityType.search page: @page, per_page: @per 
  end

  def show
    #@entity_type = GlobalRegistryModels::EntityType::EntityType.find(params[:id])
  end

  def measurement_types
    @measurement_types= GlobalRegistryModels::MeasurementType::MeasurementType.search filters:{ "related_entity_id" => params[:id] }
    render :json => @measurement_types.to_json(:only => [:name])
  end

end


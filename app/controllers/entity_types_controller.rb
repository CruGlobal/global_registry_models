class EntityTypesController < BaseController
  before_action :add_client_integration_id, only: [:create, :update]

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entity_types = entity_type_class.search page: @page, per_page: @per 
  end

  def create  
    @entity_type=entity_type_class.create(entity_type_params)
    rescue RestClient::BadRequest
    flash[:success]="Your entity type has been successfully created!" if @entity_type
    flash[:error]="An error has occured." unless @entity_type
    redirect_to entity_types_path
  end

  def update
    @entity_type=entity_type_class.update(params[:id], entity_type_params)
    rescue RuntimeError
    flash[:success]="The entity type has been successfully updated!" if @entity_type
    flash[:error]="An error has occured." unless @entity_type
    redirect_to entity_types_path
  end

  def measurement_types
    @measurement_types= GlobalRegistryModels::MeasurementType::MeasurementType.search filters:{ "related_entity_type_id" => params[:id] }
    render :json => @measurement_types.to_json(:only => [:name])
  end

private
  
  def add_client_integration_id
    params[:entity_type][:client_integration_id]=current_user.guid
  end

  def entity_type_class
    GlobalRegistryModels::EntityType::EntityType
  end

  def entity_type_params
    params.require(:entity_type).permit(:client_integration_id, :name, :description, :field_type, :is_editable, :data_visibility).reject{|_, v| v.blank?}
  end

end


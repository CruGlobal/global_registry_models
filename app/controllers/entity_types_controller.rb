class EntityTypesController < TypesController

  def index
    @page = params[:page].try(:to_i).presence || 1
    @entity_types = type_class.search( page: @page, per_page: 100).order(:name)
  end

  def measurement_types
    @measurement_types = GlobalRegistryModels::MeasurementType::MeasurementType.search filters:{ "related_entity_type_id" => params[:id].strip }
    render :json => @measurement_types.to_json(:only => [:related_entity_type_id, :name, :description, :frequency, :perm_link, :unit, :id])
  end

  private

  def ressource
    "Entity Type"
  end

  def type_params
    params.require(:entity_type).permit(:client_integration_id, :name, :description, :field_type, :is_editable, :data_visibility, :parent_id, enum_values: []).reject{|_, v| v.blank?}
  end

end


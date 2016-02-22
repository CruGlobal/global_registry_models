## Entity Types controller
class EntityTypesController < TypesController
  before_action :create_enum_values, only: :update

  def index
    @page = params[:page].try(:to_i).presence || 1
    @entity_types = type_class.search(page: @page, per_page: 100).order(:name)
  end

  def measurement_types
    @measurement_types =
      GlobalRegistryModels::MeasurementType::MeasurementType.search filters: {
        'related_entity_type_id' => params[:id].strip
      }
    render json: @measurement_types.to_json(only: [:related_entity_type_id, :name, :description,
                                                   :frequency, :perm_link, :unit, :id])
  end

  private

  def ressource
    'Entity Type'
  end

  def create_enum_values
    if params[:entity_type][:enum_values].present?
      enum_values = params[:entity_type][:enum_values].split(', ')
      GlobalRegistryModels::Entity::EnumValueBase.add_enum_value(params[:entity_type][:name], enum_values)
    end
  rescue RestClient::BadRequest, RuntimeError
    flash[:error] = 'An error has occured while saving the enum values.'
  end

  def type_params
    params.require(:entity_type)
          .permit(:client_integration_id, :name, :description, :field_type,
                  :is_editable, :data_visibility, :parent_id)
          .reject { |_, v| v.blank? }
  end
end

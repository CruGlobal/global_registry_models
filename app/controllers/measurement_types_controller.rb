## Measurement Types Controller
class MeasurementTypesController < TypesController
  private

  def ressource
    'Measurement Type'
  end

  def type_params
    params.require(:measurement_type)
          .permit(:name, :description, :perm_link, :client_integration_id,
                  :frequency, :unit, :related_entity_type_id)
          .reject { |_, v| v.blank? }
  end
end

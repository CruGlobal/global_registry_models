## Relationship Types Controller
class RelationshipTypesController < TypesController
  private

  def ressource
    'Relationship Type'
  end

  def type_params
    params.require(:relationship_type)
          .permit(:client_integration_id, :entity_type1_id, :relationship1,
                  :entity_type2_id, :relationship2)
  end
end

class RelationshipTypesController < BaseController
  before_action :add_client_integration_id, only: [:create, :update]

  def create  
    (@relationship_type=entity_type_class.create(relationship_type_params)) rescue RestClient::BadRequest
    flash[:success]="Your relationship type has been successfully added!" if @relationship_type
    flash[:error]="An error has occured." unless @relationship_type
    redirect_to entity_types_path
  end

  def update
    (@relationship_type=entity_type_class.update(params[:id], relationship_type_params)) rescue RuntimeError
    flash[:success]="The relationship type has been successfully updated!" if @relationship_type
    flash[:error]="An error has occured." unless @relationship_type
    redirect_to entity_types_path
  end

private
  
  def add_client_integration_id
    params[:relationship_type][:client_integration_id]=current_user.guid
  end

  def entity_type_class
    GlobalRegistryModels::RelationshipType::RelationshipType
  end

  def relationship_type_params
    params.require(:relationship_type).permit(:client_integration_id, :entity_type1_id, :relationship1, :entity_type2_id, :relationship2)
  end

end
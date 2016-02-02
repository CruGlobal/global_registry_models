class TypesController < BaseController
  before_action :add_client_integration_id, only: [:create, :update]

  def create  
    (@object_type=type_class.create(type_params)) rescue RestClient::BadRequest
    flash[:success]="Your #{ressource} has been successfully added!" if @object_type
    flash[:error]="An error has occured." unless @object_type
    redirect_to entity_types_path
  end

  def update
    params[:entity_type][:enum_values]=params[:entity_type][:enum_values].split(", ") if with_enum_values?
    (@object_type=type_class.update(params[:id], type_params)) rescue RuntimeError
    flash[:success]="The #{ressource} has been successfully updated!" if @object_type
    flash[:error]="An error has occured." unless @object_type
    redirect_to entity_types_path
  end

private

  def type_class
    "GlobalRegistryModels::#{stripped_ressource}::#{stripped_ressource}".constantize
  end

  def stripped_ressource 
    ressource.gsub(/\s+/, '')
  end

  def add_client_integration_id
    params[stripped_ressource.underscore.to_sym][:client_integration_id]=current_user.guid
  end

  def with_enum_values?
    params[:entity_type] && params[:entity_type][:enum_values]
  end

end
## Types Controller that relationship types, measurement types and
# entity types inherit from.
class TypesController < BaseController
  before_action :check_for_token, only: [:create, :update]

  def create
    begin
      @object_type = type_class.create(type_params)
    rescue RestClient::BadRequest
      flash[:error] = "An error has occured and the #{ressource} couldn't be created."
    else
      flash[:success] = "Your #{ressource} has been successfully added!" if @object_type
    end
    redirect_to entity_types_path
  end

  def update
    begin
      @object_type = type_class.update(params[:id], type_params)
    rescue RuntimeError
      flash[:error] = "An error has occured and the #{ressource} couldn't be updated."
    else
      flash[:success] = "The #{ressource} has been successfully updated!" if @object_type
    end
    redirect_to entity_types_path
  end

  private

  def type_class
    "GlobalRegistryModels::#{stripped_ressource}::#{stripped_ressource}".constantize
  end

  def stripped_ressource
    ressource.gsub(/\s+/, '')
  end
end

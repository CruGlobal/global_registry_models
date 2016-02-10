## Types Controller that relationship types, measurement types and
# entity types inherit from.
class TypesController < BaseController
  before_action :format_enum_values, only: :update

  def create
    begin
      @object_type = type_class.create(type_params)
    rescue RestClient::BadRequest
      flash[:error] = 'An error has occured.'
    else
      flash[:success] = "Your #{ressource} has been successfully added!" if @object_type
    end
    redirect_to entity_types_path
  end

  def update
    begin
      @object_type = type_class.update(params[:id], type_params)
    rescue RuntimeError
      flash[:error] = 'An error has occured.'
    else
      flash[:success] = "The #{ressource} has been successfully updated!" if @object_type
    end
    redirect_to entity_types_path
  end

  private

  def format_enum_values
    if with_enum_values?
      params[:entity_type][:enum_values] =
        params[:entity_type][:enum_values].split(', ')
    end
  end

  def type_class
    "GlobalRegistryModels::#{stripped_ressource}::#{stripped_ressource}"
      .constantize
  end

  def stripped_ressource
    ressource.gsub(/\s+/, '')
  end

  def with_enum_values?
    params[:entity_type] && params[:entity_type][:enum_values]
  end
end

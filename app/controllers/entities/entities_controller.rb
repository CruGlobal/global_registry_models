class Entities::EntitiesController < BaseController

  before_action :load_entity_class

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @entities = @entity_class.search page: @page, per_page: @per, filters: params[:filters]
  end

  def show
    @entity = @entity_class.find(params[:id])
  end

  private

    def load_entity_class
      @entity_class = "GlobalRegistryModels::Entity::#{ params[:entity_class_name].singularize.classify }".safe_constantize
      redirect_to root_path if @entity_class.blank?
    end

end


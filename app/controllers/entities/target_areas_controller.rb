class Entities::TargetAreasController < BaseController

  def index
    @per = 25
    @page = params[:page].try(:to_i).presence || 1
    @target_areas = Entity::TargetArea.search page: @page, per_page: @per, filters: params[:filters]
    @entity_class = Entity::TargetArea
  end

  def show
    @target_area = Entity::TargetArea.find(params[:id])
  end

end

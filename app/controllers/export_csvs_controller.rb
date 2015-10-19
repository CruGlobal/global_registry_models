class ExportCsvsController < BaseController

  def create
    if params[:entity_class_name].present? && params[:email].present?
      ExportCsvJob.perform_later entity_class_name: params[:entity_class_name], filters: params[:filters], email: params[:email]
      redirect_to :back, flash: { success: "The CSV export of #{ params[:entity_class_name].titleize.pluralize } has started and it will be emailed to #{ params[:email] } when it's ready." }
    else
      redirect_to :back, flash: { error: "Oops! Couldn't start the CSV export." }
    end
  end

end

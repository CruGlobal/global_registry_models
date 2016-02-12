## Export Csvs Controller
class ExportCsvsController < BaseController
  before_action :check_params

  def create
    ExportCsvJob.perform_later entity_class_name: params[:entity_class_name],
                               filters: params[:filters],
                               email: params[:email]
    redirect_to :back, flash: { success: "The CSV export of
                                          #{params[:entity_class_name].titleize.pluralize}
                                          has started and it will be emailed
                                          to #{params[:email]} when it's ready." }
  end

  private

  def check_params
    unless params[:entity_class_name].present? && params[:email].present?
      redirect_to :back, flash: {
        error: "Oops! Couldn't start the CSV export."
      }
    end
  end
end

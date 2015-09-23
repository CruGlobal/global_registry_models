class ExportCsvsController < ApplicationController

  def create
    if params[:entity_type].present? && params[:email].present?
      ExportCsvJob.perform_later entity_type: params[:entity_type], filters: params[:filters], email: params[:email]
      redirect_to :back, flash: { success: "We've started exporting the #{ params[:entity_type].titleize.pluralize }, we'll email the CSV to #{ params[:email] } when it's ready." }
    else
      redirect_to :back, flash: { error: "Oops! Couldn't start the CSV export." }
    end
  end

end

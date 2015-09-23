class ExportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(entity_type:, filters:, email:)
    ExportCsv.new(entity_class: "Entity::#{ entity_type.classify }".safe_constantize, filters: filters, email: email).export! do |file_name, file|
      ExportCsvMailer.send_export(email, file_name, file.path).deliver_now
    end
  end

end

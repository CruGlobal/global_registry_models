class ExportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(entity_class_name:, filters:, email:)
    ExportCsv.new(entity_class: "GlobalRegistryModels::Entity::#{entity_class_name.singularize.classify}"
             .safe_constantize, filters: filters, email: email).export! do |file_name, file|
      ExportCsvMailer.send_export(email, file_name, file.path).deliver_now
    end
  rescue Net::HTTPGatewayTimeOut
    ExportCsvMailer.send_export(email, entity_class_name).deliver_now
  end
end

class ExportCsvMailer < ApplicationMailer
  def send_export(email, file_name, file_path)
    @file_name = file_name
    attachments[file_name] = File.read(file_path)
    mail to: email, subject: 'Your requested CSV export from Nebo'
  end

  def send_error(email, entity_class_name)
    @entity_class_name = entity_class_name
    mail to: email, subject: 'Your requst has too many results'
  end
end

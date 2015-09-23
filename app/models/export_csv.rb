class ExportCsv
  include Virtus.model

  attribute :entity_class, Class
  attribute :filters, Hash

  def export!
    entity_collection = entity_class.all! filters: filters

    Tempfile.open file_name do |f|
      f.print entity_collection.to_csv
      f.flush
      f.rewind
      yield file_name, f
    end
  end

  private

    def file_name
      @file_name ||= 'nebo_export.csv'
    end

end
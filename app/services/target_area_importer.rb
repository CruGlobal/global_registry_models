require 'csv'
require 'securerandom'

class TargetAreaImporter

  def spreadsheet_file_path=(path)
    @spreadsheet_file_path = path
    puts 'Building target areas from spreadsheet ...'
    @target_areas = build_target_areas
  end

  def import
    print 'Fetching global ministries '
    global_ministries
    puts ' done'

    print 'Fetching all target areas '
    all_target_areas
    puts ' done'

    time = Time.now.to_i
    imported_csv = CSV.open(Rails.root.join("tmp/at_#{ time }_imported_target_areas.csv"), 'wb')
    failed_to_import_csv = CSV.open(Rails.root.join("tmp/at_#{ time }_failed_to_import_target_areas.csv"), 'wb')

    imported_csv << Entity::TargetArea.attribute_names
    failed_to_import_csv << Entity::TargetArea.attribute_names

    puts 'Importing target areas ...'
    @target_areas.each do |target_area|
      begin
        print %("#{ target_area.name }" ... )
        import_target_area!(target_area)
        write_target_area_to_csv(target_area, imported_csv)
        puts 'success'
      rescue => exception
        write_target_area_to_csv(target_area, failed_to_import_csv)
        puts "failed! #{ exception }"
      end
    end

    imported_csv.close
    failed_to_import_csv.close

    puts 'Finished'
  end

  private

    def write_target_area_to_csv(target_area, csv)
      csv << Entity::TargetArea.attribute_names.collect do |attribute|
        target_area.send(attribute)
      end
      csv.flush
    end

    def new_uuid
      SecureRandom.uuid
    end

    def all_target_areas
      @all_target_areas ||= Entity::TargetArea.all!
    end

    def global_ministries
      @global_ministries ||= Entity::Ministry.all!(ruleset: 'global_ministries')
    end

    def find_duplicate_target_area(target_area)
      all_target_areas.detect do |existing_target_area|
        duplicate_target_areas?(existing_target_area, target_area)
      end
    end

    def duplicate_target_areas?(target_area_a, target_area_b)
      target_area_a.name == target_area_b.name &&
        target_area_a.country == target_area_b.country &&
        target_area_a.city == target_area_b.city
    end

    def find_and_assign_duplicate_target_area(target_area)
      return target_area unless dup_target_area = find_duplicate_target_area(target_area)

      target_area.attributes.except(:id).each do |attribute, value|
        dup_target_area.send("#{ attribute }=", value) if value.present?
      end

      dup_target_area
    end

    def import_target_area!(target_area)
      target_area = find_and_assign_duplicate_target_area(target_area)

      target_area.client_integration_id ||= new_uuid

      raise unless Retryer.new(RestClient::InternalServerError, max_attempts: nil).try { target_area.save } && target_area.id.present?

      raise unless ministry_id = ministry_for_target_area(target_area).id

      raise unless Retryer.new(RestClient::InternalServerError, max_attempts: nil).try do
        GlobalRegistry::Entity.put(ministry_id, {
          'entity' => {
            'ministry' => {
              'client_integration_id' => new_uuid,
              'activity:relationship' => {
                'target_area' => target_area.id,
                'client_integration_id' => new_uuid
              }
            }
          }
        })
      end

      target_area
    end

    def ministry_for_target_area(target_area)
      case target_area.country
      when 'USA'
        global_ministries.detect { |ministry| ministry.min_code == 'US1' }
      when 'China'
        min_code = {
          'ROL' => 'CNA',
          'BJ' => 'CNB',
          'ZONE' => 'CNC',
          'SE' => 'CND',
          'MCR' => 'CNE',
          'SW' => 'CNF',
          'SRR' => 'CNG',
          'NE' => 'CNH',
          'HK' => 'HOK'
        }[target_area.region.upcase]
        global_ministries.detect { |ministry| ministry.min_code == min_code }
      else
        global_ministries.detect { |ministry| ministry.name == target_area.country }
      end
    end

    def build_target_areas
      return nil unless open_spreadsheet

      target_areas = []

      (2..@spreadsheet.last_row).each do |i|
        row = Hash[[header_row, @spreadsheet.row(i)].transpose]
        row.each { |k, v| row[k] = v.strip if v.is_a?(String) }
        built_target_area = Entity::TargetArea.new(row)
        target_areas << built_target_area unless target_areas.detect { |target_area| duplicate_target_areas?(built_target_area, target_area) }
      end

      target_areas
    end

    def open_spreadsheet
      extension = File.extname(@spreadsheet_file_path)[1..-1]
      @spreadsheet = Roo::Spreadsheet.open(@spreadsheet_file_path, extension: extension)
    rescue => e
      @spreadsheet = nil
      raise "The file at #{ @spreadsheet_file_path } doesn't appear to be a spreadsheet!"
    end

    def header_row
      return nil unless @spreadsheet
      @header_row ||= @spreadsheet.row(1).collect(&:downcase)
    end
end

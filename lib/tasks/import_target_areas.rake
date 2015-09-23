task :import_target_areas do
  spreadsheet_file_path = ENV['spreadsheet_file_path']
  raise 'No spreadsheet_file_path specified!' unless spreadsheet_file_path.present?
  raise 'Specified file does not exist!' unless File.exist?(spreadsheet_file_path)
  puts "Importing from spreadsheet #{ spreadsheet_file_path }"

  importer = TargetAreaImporter.new
  importer.spreadsheet_file_path = spreadsheet_file_path
  importer.import

  puts 'Exiting rake task'
end

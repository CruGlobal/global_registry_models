require 'test_helper'

class ExportCsvTest < ActiveSupport::TestCase

  test '#export!' do
    GlobalRegistry.access_token ||= 'test'
    export_csv = ExportCsv.new entity_class: GlobalRegistryModels::Entity::Test, filters: {}
    export_csv.export! do |file_name, file|
      assert_equal 'nebo_tests_export.csv', file_name
      assert_instance_of Tempfile, file
      assert_equal ["client_integration_id,id,name,phone\n",
                    "1234,0000-0000-0000-0001,Mr. Test,+1234567890\n",
                    "2222,0000-0000-0000-0002,Count Testalot,1800TEST\n",
                    "1234,0000-0000-0000-0001,Mr. Test,+1234567890\n",
                    "2222,0000-0000-0000-0002,Count Testalot,1800TEST\n"], file.readlines
    end
  end

end

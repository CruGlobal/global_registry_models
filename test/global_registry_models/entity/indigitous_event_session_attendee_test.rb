require 'test_helper'

class GlobalRegistryModelsEntityIndigitousEventSessionAttendeeTest < Minitest::Test

  def test_initialize
    attendee = GlobalRegistryModels::Entity::IndigitousEventSessionAttendee.new({'first_name' => 'Test', 'last_name'=> 'Person'})
    assert_instance_of GlobalRegistryModels::Entity::IndigitousEventSessionAttendee, attendee
    assert_equal 'Test', attendee.first_name
  end

  def test_to_s
    assert_equal 'Test Person', GlobalRegistryModels::Entity::IndigitousEventSessionAttendee.new({'first_name' => 'Test', 'last_name'=> 'Person'}).to_s
  end

end

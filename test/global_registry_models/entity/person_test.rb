require 'test_helper'

class GlobalRegistryModelsEntityPersonBaseTest < Minitest::Test

  def test_initialize
    person = GlobalRegistryModels::Entity::Person.new({'first_name' => 'test', 'gsw_access'=> true, 'authentication' => {'key_guid' => 'FF44131FFCXZ-11212ASAAS'}})
    assert_instance_of GlobalRegistryModels::Entity::Person, person
    assert_equal 'FF44131FFCXZ-11212ASAAS', person.key_guid
  end

  def test_to_s
    assert_equal 'Testing 123', GlobalRegistryModels::Entity::Person.new({first_name: 'Testing', last_name: '123'}).to_s
  end

end

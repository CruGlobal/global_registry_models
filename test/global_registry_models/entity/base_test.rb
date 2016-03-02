require 'test_helper'

class GlobalRegistryModelsEntityBaseTest < Minitest::Test

  def test_title
    assert_equal 'Test', GlobalRegistryModels::Entity::Test.title
    assert_equal 'Tests', GlobalRegistryModels::Entity::Test.title.pluralize
  end

  def test_identifying_attributes
    assert_equal [:id], GlobalRegistryModels::Entity::Test.identifying_attributes
  end

  def test_filterable_attributes
    assert_equal [:client_integration_id, :phone, :name, :is_active], GlobalRegistryModels::Entity::Test.filterable_attributes
  end

  def test_writeable_attributes
    assert_equal [:client_integration_id, :phone, :name, :is_active], GlobalRegistryModels::Entity::Test.writeable_attributes
  end

  def test_initialize_ignores_non_attribute_keys
    tester = GlobalRegistryModels::Entity::Test.new name: 'Mr. Test', my_favourite_colour: 'blue'
    assert_equal({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: nil, is_active: nil }, tester.attributes)
  end

  def test_attribute_names
    assert_equal [:id, :client_integration_id, :phone, :name, :is_active], GlobalRegistryModels::Entity::Test.attribute_names
  end

  def test_attributes
    tester = GlobalRegistryModels::Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert_equal({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO', is_active: nil }, tester.attributes)
    tester.name = 'Count Test'
    assert_equal({ id: nil, client_integration_id: nil, name: 'Count Test', phone: '1-800-TEST-MEYO', is_active: nil }, tester.attributes)
  end

  def test_attributes=
    tester = GlobalRegistryModels::Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert_equal({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO', is_active: nil }, tester.attributes)
    tester.attributes = { name: 'Ms. Test', phone: '123.4567' }
    assert_equal({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567', is_active: nil }, tester.attributes)
    tester.attributes = {}
    assert_equal({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567', is_active: nil }, tester.attributes)
    tester.attributes = { name: 'Sir Test' }
    assert_equal({ id: nil, client_integration_id: nil, name: 'Sir Test', phone: '123.4567', is_active: nil }, tester.attributes)
  end

  def test_name
    assert_equal 'test', GlobalRegistryModels::Entity::Test.name
  end

  def test_with_relationship
    tester = GlobalRegistryModels::Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO', "wife:relationship": {
                "person": "77d483f4-508c-11e4-b8da-1fd48c4c6c72",
                "relationship_entity_id": "43d74164-554f-11e4-9093-4a5703049b5d",
                "client_integration_id": "44"
            }
    assert_instance_of GlobalRegistryModels::Entity::Relationship, tester.relationships.first
    assert_equal '77d483f4-508c-11e4-b8da-1fd48c4c6c72', tester.relationships.first.related_entity_id
  end

  def test_create_with_relationship
    tester = GlobalRegistryModels::Entity::Test.create name: 'Mr. Test', phone: '1-800-TEST-MEYO', client_integration_id: '12121', "wife:relationship": {
                "person": "77d483f4-508c-11e4-b8da-1fd48c4c6c72",
                "relationship_entity_id": "43d74164-554f-11e4-9093-4a5703049b5d",
                "client_integration_id": "44"
            }
    assert_requested :post, 'https://test-api.global-registry.org/entities', body: '{"entity":{"test":{"name":"Mr. Test","phone":"1-800-TEST-MEYO","client_integration_id":"12121","wife:relationship":{"person":"77d483f4-508c-11e4-b8da-1fd48c4c6c72","client_integration_id":"44"}}}}'
  end

end

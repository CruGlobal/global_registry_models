require 'test_helper'

class GlobalRegistryModelsEntityBasePersistenceTest < Minitest::Test

  def test_class_create_bang
    entity = GlobalRegistryModels::Entity::Test.create!(name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1')
    assert_instance_of GlobalRegistryModels::Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :post, 'https://test-api.global-registry.org/entities'
  end

  def test_class_create_bang_when_invalid
    assert_raises GlobalRegistryModels::RecordInvalid do
      GlobalRegistryModels::Entity::Test.create!({})
    end
    assert_not_requested :post, 'https://test-api.global-registry.org/entities'
  end

  def test_class_create_coerces_attributes
    assert GlobalRegistryModels::Entity::Test.create(client_integration_id: 1, is_active: '0')
    assert_requested :post, 'https://test-api.global-registry.org/entities', body: '{"entity":{"test":{"client_integration_id":"1","is_active":false}}}'
  end

  def test_class_create_only_updates_writeable_attributes
    assert GlobalRegistryModels::Entity::Test.create(id: 'trying-to-update-id', client_integration_id: 1, is_active: '0')
    assert_requested :post, 'https://test-api.global-registry.org/entities', body: '{"entity":{"test":{"client_integration_id":"1","is_active":false}}}'
  end

  def test_class_create
    entity = GlobalRegistryModels::Entity::Test.create name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert_instance_of GlobalRegistryModels::Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :post, 'https://test-api.global-registry.org/entities'
  end

  def test_class_create_when_invalid
    assert !GlobalRegistryModels::Entity::Test.create({})
    assert_not_requested :post, "https://test-api.global-registry.org/entities"
  end

  def test_class_update_bang
    entity = GlobalRegistryModels::Entity::Test.update!('0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1')
    assert_instance_of GlobalRegistryModels::Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_class_update_bang_when_invalid
    assert_raises GlobalRegistryModels::RecordInvalid do
      GlobalRegistryModels::Entity::Test.update!('0000-0000-0000-0001', {})
    end
    assert_not_requested :put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001"
  end

  def test_class_update
    entity = GlobalRegistryModels::Entity::Test.update '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert_instance_of GlobalRegistryModels::Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_class_update_when_invalid
    assert !GlobalRegistryModels::Entity::Test.update('0000-0000-0000-0001', {})
    assert_not_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_class_update_coerces_attributes
    assert GlobalRegistryModels::Entity::Test.update('0000-0000-0000-0001', client_integration_id: 1, is_active: '0')
    assert_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001', body: '{"entity":{"test":{"client_integration_id":"1","is_active":false}}}'
  end

  def test_class_update_only_updates_writeable_attributes
    assert GlobalRegistryModels::Entity::Test.update('0000-0000-0000-0001', id: 'trying-to-update-id', client_integration_id: 1, is_active: '0')
    assert_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001', body: '{"entity":{"test":{"client_integration_id":"1","is_active":false}}}'
  end

  def test_update_bang
    entity = GlobalRegistryModels::Entity::Test.new name: 'Name', phone: 'Phone', client_integration_id: '1', id: '0000-0000-0000-0001'
    response = entity.update!(name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1')
    assert_instance_of GlobalRegistryModels::Entity::Test, response
    assert_equal 'Mr. Test', response.name
    assert_equal '1800TEST', response.phone
    assert_equal '1', response.client_integration_id
    assert_equal '0000-0000-0000-0001', response.id
    assert :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_update_bang_without_client_integration_id
    entity = GlobalRegistryModels::Entity::Test.new name: 'Name', phone: 'Phone', client_integration_id: '1', id: '0000-0000-0000-0001'
    response = entity.update!(name: 'Mr. Test', phone: '1800TEST')
    assert_instance_of GlobalRegistryModels::Entity::Test, response
    assert_equal 'Mr. Test', response.name
    assert_equal '1800TEST', response.phone
    assert_equal '1', response.client_integration_id
    assert_equal '0000-0000-0000-0001', response.id
    assert :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_save_without_id
    entity = GlobalRegistryModels::Entity::Test.new name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert entity.save
    assert_equal({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1', is_active: nil }, entity.attributes)
    assert_requested :post, 'https://test-api.global-registry.org/entities'
  end

  def test_save_with_id
    entity = GlobalRegistryModels::Entity::Test.find '0000-0000-0000-0001'
    entity.phone = '1800TEST'
    entity.client_integration_id = '1'
    assert entity.save
    assert_equal({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1', is_active: true }, entity.attributes)
    assert_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_save_when_invalid
    entity = GlobalRegistryModels::Entity::Test.new name: 'Test', id: nil
    assert !entity.save
    assert_not_requested :put, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_add_enum_value
    entity = GlobalRegistryModels::Entity::EnumValueBase.add_enum_value('search_engine', ['random_engine','other_random_engine'])
    assert_requested :post, 'https://test-api.global-registry.org/entities'
  end

end


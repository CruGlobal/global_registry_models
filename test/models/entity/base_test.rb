require 'test_helper'

class BaseTest < ActiveSupport::TestCase

  test '.initialize ignores non attribute keys' do
    tester = Entity::Test.new name: 'Mr. Test', my_favourite_colour: 'blue'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: nil } == tester.attributes)
  end

  test '.attribute_names' do
    assert_equal [:id, :client_integration_id, :phone, :name], Entity::Test.attribute_names
  end

  test '#attributes' do
    tester = Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
    tester.name = 'Count Test'
    assert ({ id: nil, client_integration_id: nil, name: 'Count Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
  end

  test '#attributes=' do
    tester = Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
    tester.attributes = { name: 'Ms. Test', phone: '123.4567' }
    assert ({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567' } == tester.attributes)
    tester.attributes = {}
    assert ({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567' } == tester.attributes)
    tester.attributes = { name: 'Sir Test' }
    assert ({ id: nil, client_integration_id: nil, name: 'Sir Test', phone: '123.4567' } == tester.attributes)
  end

  test '.name' do
    assert_equal 'test', Entity::Test.name
  end

  test '.create' do
    entity = Entity::Test.create name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert_instance_of Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :post, 'https://stage-api.global-registry.org/entities'
  end

  test '.create when invalid' do
    assert_not Entity::Test.create({})
    assert_not_requested :post, "https://stage-api.global-registry.org/entities"
  end

  test '.update' do
    entity = Entity::Test.update '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert_instance_of Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :put, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '.update when invalid' do
    assert_not Entity::Test.update '0000-0000-0000-0001', {}
    assert_not_requested :put, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001"
  end

  test '.delete' do
    assert Entity::Test.delete '0000-0000-0000-0001'
    assert_requested :delete, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '#delete' do
    entity = Entity::Test.find '0000-0000-0000-0001'
    assert entity.delete
    assert_requested :delete, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '#delete without id' do
    entity = Entity::Test.new name: 'Test', id: nil
    assert_not entity.delete
    assert_not_requested :delete, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '#save without id' do
    entity = Entity::Test.new name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1'
    assert entity.save
    assert ({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1' } == entity.attributes)
    assert_requested :post, 'https://stage-api.global-registry.org/entities'
  end

  test '#save with id' do
    entity = Entity::Test.find '0000-0000-0000-0001'
    entity.phone = '1800TEST'
    entity.client_integration_id = '1'
    assert entity.save
    assert ({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: '1' } == entity.attributes)
    assert_requested :put, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '#save when invalid' do
    entity = Entity::Test.new name: 'Test', id: nil
    assert_not entity.save
    assert_not_requested :put, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

end

require 'test_helper'

# A Test class that we'll use to test the Base class
module Entity
  class Test < Entity::Base
    has_attributes :id, :name, 'phone'
  end
end

class BaseTest < ActiveSupport::TestCase

  test '.initialize ignores non attribute keys' do
    tester = Entity::Test.new name: 'Mr. Test', my_favourite_colour: 'blue'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: nil } == tester.attributes)
  end

  test '.has_attributes defines attr_accessors' do
    assert_respond_to Entity::Test.new, 'name'
    assert_respond_to Entity::Test.new, 'name='
    assert_respond_to Entity::Test.new, 'phone'
    assert_respond_to Entity::Test.new, 'phone='
  end

  test '.has_attributes defines .attribute_names' do
    assert_respond_to Entity::Test, 'attribute_names'
  end

  test '.has_attributes defines #attributes' do
    assert_respond_to Entity::Test.new, 'attributes'
  end

  test '.has_attributes defines #assign_attributes' do
    assert_respond_to Entity::Test.new, 'assign_attributes'
  end

  test '.attribute_names' do
    assert ([:id, :name, :phone, :client_integration_id] == Entity::Test.attribute_names)
  end

  test '#attributes' do
    tester = Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
    tester.name = 'Count Test'
    assert ({ id: nil, client_integration_id: nil, name: 'Count Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
  end

  test '#assign_attributes' do
    tester = Entity::Test.new name: 'Mr. Test', phone: '1-800-TEST-MEYO'
    assert ({ id: nil, client_integration_id: nil, name: 'Mr. Test', phone: '1-800-TEST-MEYO' } == tester.attributes)
    tester.assign_attributes name: 'Ms. Test', phone: '123.4567'
    assert ({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567' } == tester.attributes)
    tester.assign_attributes {}
    assert ({ id: nil, client_integration_id: nil, name: 'Ms. Test', phone: '123.4567' } == tester.attributes)
    tester.assign_attributes name: 'Sir Test'
    assert ({ id: nil, client_integration_id: nil, name: 'Sir Test', phone: '123.4567' } == tester.attributes)
  end

  test '.name' do
    assert_equal 'test', Entity::Test.name
  end

  test '.search blank' do
    found = Entity::Test.search
    assert_instance_of Array, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test'
  end

  test '.search with filters' do
    found = Entity::Test.search(filters: { name: 'Mr', phone: '1-800-TEST', attribute: { nested: 'test' }, 'person:relationship:role:exists' => '' })
    assert_instance_of Array, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bperson:relationship:role:exists%5D=&filters%5Bphone%5D=1-800-TEST'
  end

  test '.search with order' do
    found = Entity::Test.search(order: 'name asc,phone desc')
    assert_instance_of Array, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&order=name%20asc,phone%20desc'
  end

  test '.search with pagination' do
    found = Entity::Test.search(page: 45, per_page: 76)
    assert_instance_of Array, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&page=45&per_page=76'
  end

  test '.find' do
    found = Entity::Test.find '0000-0000-0000-0001'
    assert_instance_of Entity::Test, found
    assert_equal '0000-0000-0000-0001', found.id
    assert_requested :get, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '.page' do
    found = Entity::Test.page 1
    assert_instance_of Array, found
    found.all? { |f| assert_instance_of(Entity::Test, f) }
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&page=1'
  end

  test '.create' do
    entity = Entity::Test.create name: 'Mr. Test', phone: '1800TEST', client_integration_id: 1
    assert_instance_of Entity::Test, entity
    assert_equal '0000-0000-0000-0001', entity.id
    assert_requested :post, 'https://stage-api.global-registry.org/entities'
  end

  test '.create when invalid' do
    assert_not Entity::Test.create({})
    assert_not_requested :post, "https://stage-api.global-registry.org/entities"
  end

  test '.update' do
    entity = Entity::Test.update '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: 1
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
    entity = Entity::Test.new name: 'Mr. Test', phone: '1800TEST', client_integration_id: 1
    assert entity.save
    assert ({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: 1 } == entity.attributes)
    assert_requested :post, 'https://stage-api.global-registry.org/entities'
  end

  test '#save with id' do
    entity = Entity::Test.find '0000-0000-0000-0001'
    entity.phone = '1800TEST'
    entity.client_integration_id = 1
    assert entity.save
    assert ({ id: '0000-0000-0000-0001', name: 'Mr. Test', phone: '1800TEST', client_integration_id: 1 } == entity.attributes)
    assert_requested :put, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '#save when invalid' do
    entity = Entity::Test.new name: 'Test', id: nil
    assert_not entity.save
    assert_not_requested :put, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

end

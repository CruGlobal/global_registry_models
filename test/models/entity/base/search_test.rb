require 'test_helper'

class BaseSearchTest < ActiveSupport::TestCase

  test '.search blank' do
    found = Entity::Test.search
    assert_instance_of Entity::Collection, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test'
  end

  test '.search with basic filters' do
    found = Entity::Test.search(filters: { name: 'Mr', phone: '1-800-TEST', attribute: { nested: 'test' }, blank: '' })
    assert_instance_of Entity::Collection, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bphone%5D=1-800-TEST'
  end

  test '.search with relationship filters' do
    found = Entity::Test.search(filters: { 'wife:relationship' => { 'first_name' => 'wilma' }, 'ministry:relationship:role' => 'Director' })
    assert_instance_of Entity::Collection, found
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&filters%5Bministry:relationship:role%5D=Director&filters%5Bwife:relationship%5D%5Bfirst_name%5D=wilma'
  end

  test '.search with order' do
    found = Entity::Test.search(order: 'name asc,phone desc')
    assert_instance_of Entity::Collection, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&order=name%20asc,phone%20desc'
  end

  test '.search with pagination' do
    found = Entity::Test.search(page: 45, per_page: 76)
    assert_instance_of Entity::Collection, found
    assert_instance_of Entity::Test, found.first
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&page=45&per_page=76'
  end

end

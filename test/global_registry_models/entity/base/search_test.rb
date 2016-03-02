require 'test_helper'

class GlobalRegistryModelsEntityBaseSearchTest < Minitest::Test

  def test_search_blank
    found = GlobalRegistryModels::Entity::Test.search
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_instance_of GlobalRegistryModels::Entity::Test, found.first
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*'
  end

  def test_search_with_basic_filters
    found = GlobalRegistryModels::Entity::Test.search(filters: { name: 'Mr', phone: '1-800-TEST', attribute: { nested: 'test' }, blank: '' })
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_instance_of GlobalRegistryModels::Entity::Test, found.first
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bphone%5D=1-800-TEST'
  end

  def test_search_with_relationship_filters
    found = GlobalRegistryModels::Entity::Test.search(filters: { 'wife:relationship' => { 'first_name' => 'wilma' }, 'ministry:relationship:role' => 'Director' })
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*&filters%5Bministry:relationship:role%5D=Director&filters%5Bwife:relationship%5D%5Bfirst_name%5D=wilma'
  end

  def test_search_with_order
    found = GlobalRegistryModels::Entity::Test.search(order: 'name asc,phone desc')
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_instance_of GlobalRegistryModels::Entity::Test, found.first
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*&order=name%20asc,phone%20desc'
  end

  def test_search_with_pagination
    found = GlobalRegistryModels::Entity::Test.search(page: 45, per_page: 76)
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_instance_of GlobalRegistryModels::Entity::Test, found.first
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*&page=45&per_page=76'
  end
end

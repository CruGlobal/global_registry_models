require 'test_helper'

class GlobalRegistryModelsEntityBaseFindersTest < Minitest::Test

  def test_all!
    found = GlobalRegistryModels::Entity::Test.all!
    assert_instance_of GlobalRegistryModels::Collection, found
    assert_equal 4, found.count
    found.each do |entity|
      assert_instance_of GlobalRegistryModels::Entity::Test, entity
    end
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&page=1&fields=*'
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&page=2&fields=*'
    assert_not_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&page=3&fields=*'
    assert_not_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&page=4&fields=*'
  end

  def test_find
    found = GlobalRegistryModels::Entity::Test.find '0000-0000-0000-0001'
    assert_instance_of GlobalRegistryModels::Entity::Test, found
    assert_equal '0000-0000-0000-0001', found.id
    assert_requested :get, 'https://test-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  def test_page
    found = GlobalRegistryModels::Entity::Test.page 1
    assert_instance_of GlobalRegistryModels::Collection, found
    found.all? { |f| assert_instance_of(GlobalRegistryModels::Entity::Test, f) }
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=test&fields=*&page=1'
  end

end

require 'test_helper'

class BaseFindersTest < ActiveSupport::TestCase

  test '.find' do
    found = Entity::Test.find '0000-0000-0000-0001'
    assert_instance_of Entity::Test, found
    assert_equal '0000-0000-0000-0001', found.id
    assert_requested :get, 'https://stage-api.global-registry.org/entities/0000-0000-0000-0001'
  end

  test '.page' do
    found = Entity::Test.page 1
    assert_instance_of Entity::Collection, found
    found.all? { |f| assert_instance_of(Entity::Test, f) }
    assert_requested :get, 'https://stage-api.global-registry.org/entities?entity_type=test&page=1'
  end

end

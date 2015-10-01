require 'test_helper'

class BaseDeleteTest < ActiveSupport::TestCase

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

end


require 'test_helper'

class GlobalRegistryModelsEntityIndigitousEventHashTest < Minitest::Test

  def test_initialize
    event = GlobalRegistryModels::Entity::IndigitousEventHash.new({'city' => 'Montreal', 'date' => Date.new(2015,6,19) })
    assert_instance_of GlobalRegistryModels::Entity::IndigitousEventHash, event
    assert_equal 'Montreal', event.city
  end

  def test_to_s
    assert_equal 'Montreal 2015-06-19', GlobalRegistryModels::Entity::IndigitousEventHash.new({'city' => 'Montreal', 'date' => Date.new(2015,6,19) }).to_s
  end

end

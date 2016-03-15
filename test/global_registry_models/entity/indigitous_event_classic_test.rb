require 'test_helper'

class GlobalRegistryModelsEntityIndigitousEventClassicTest < Minitest::Test

  def test_initialize
    event = GlobalRegistryModels::Entity::IndigitousEventClassic.new({'city' => 'Montreal', 'date'=> '19/06/2015'})
    assert_instance_of GlobalRegistryModels::Entity::IndigitousEventClassic, event
    assert_equal 'Montreal', event.city
  end

  def test_to_s
    assert_equal 'Montreal 19/06/2015', GlobalRegistryModels::Entity::IndigitousEventClassic.new({'city' => 'Montreal', 'date'=> '19/06/2015'}).to_s
  end

end

require 'test_helper'

class GlobalRegistryModelsEntityIndigitousEventSessionTest < Minitest::Test

  def test_initialize
    event = GlobalRegistryModels::Entity::IndigitousEventSession.new({'title' => 'Session', 'date'=> Date.new(2015,6,19)})
    assert_instance_of GlobalRegistryModels::Entity::IndigitousEventSession, event
    assert_equal '2015-06-19', event.date.to_s
  end

  def test_to_s
    assert_equal 'Session', GlobalRegistryModels::Entity::IndigitousEventSession.new({'title' => 'Session'}).to_s
  end

end

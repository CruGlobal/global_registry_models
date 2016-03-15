require 'test_helper'

class GlobalRegistryModelsEntityRelationshipTest < Minitest::Test
  def test_initialize
    relationship = GlobalRegistryModels::Entity::Relationship.new({relationship_type: 'friend', entity_type: 'person',
                                                             related_entity_id: 'ASSWWAS1212SAX', client_integration_id: '12345'})
    assert_instance_of GlobalRegistryModels::Entity::Relationship, relationship
    assert_equal 'ASSWWAS1212SAX', relationship.related_entity_id
  end
end

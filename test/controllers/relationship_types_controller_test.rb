require 'test_helper'

class RelationshipTypesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test 'POST relationship_types' do
    post :create, relationship_type: {entity_type1_id: 'ss5sasxxs5', entity_type2_id: 'ss5sasxxs5', relationship1: 'father', relationship2: 'son'}
    assert_redirected_to entity_types_path
    assert_instance_of GlobalRegistryModels::RelationshipType::RelationshipType, assigns[:object_type]
  end

  test 'PUT relationship_types' do
    post :update, id: 'a0xxs00a-sx033', relationship_type: {entity_type1_id: 'ss5sasxxs5', entity_type2_id: 'ss5sasxxs5', relationship1: 'father', relationship2: 'son'}
    assert_redirected_to entity_types_path
    assert_instance_of GlobalRegistryModels::RelationshipType::RelationshipType, assigns[:object_type]
  end

end
require 'test_helper'

class EntityTypesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test 'GET index' do
    get :index
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_instance_of GlobalRegistryModels::EntityType::EntityType, assigns[:entity_types].first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first.fields.first
    assert_instance_of GlobalRegistryModels::RelationshipType::RelationshipType, assigns[:entity_types].last.relationships.first
    assert_instance_of GlobalRegistryModels::RelationshipType::InvolvedType, assigns[:entity_types].last.relationships.first.involved_types.first
    assert_match "person <--- ( person / ministry ) ---> ministry", response.body
    assert_equal 1, assigns[:page]
  end

  test 'GET index with page' do
    get :index, page: 2
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_equal 2, assigns[:page]
  end

end

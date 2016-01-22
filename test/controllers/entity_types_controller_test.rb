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
    assert_instance_of GlobalRegistryModels::RelationshipType::RelationshipType, assigns[:relationship_types].first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first.fields.first
    assert_match "position_role <--- ( boss / employee ) ---> position_role", response.body
    assert_equal 1, assigns[:page]
  end

  test 'GET index with page' do
    get :index, page: 2
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_equal 2, assigns[:page]
  end

end

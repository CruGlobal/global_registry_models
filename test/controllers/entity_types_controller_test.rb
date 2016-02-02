require 'test_helper'

class EntityTypesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test 'GET index' do
    get :index
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_instance_of class_name, assigns[:entity_types].first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first
    assert_instance_of GlobalRegistryModels::EntityType::Field, assigns[:entity_types].last.fields.first.fields.first
    assert_instance_of GlobalRegistryModels::RelationshipType::RelationshipType, assigns[:entity_types].last.relationships.first
    assert_instance_of GlobalRegistryModels::RelationshipType::InvolvedType, assigns[:entity_types].last.relationships.first.involved_types.first
    assert_match "<p>ministry</p> ) --->", response.body
    assert_match "<--- ( <p>person</p> /", response.body                            
    assert_equal 1, assigns[:page]
  end

  test 'GET index with page' do
    get :index, page: 2
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_equal 2, assigns[:page]
  end

  test 'GET measurement_types' do
    get :measurement_types, id: 'a0xxs00a-sx033'
    assert_response :success
    assert assigns[:measurement_types].all.size > 1
    assert_instance_of GlobalRegistryModels::MeasurementType::MeasurementType, assigns[:measurement_types].first
  end

  test 'POST entity_types' do
    post :create, entity_type: entity_type_params
    assert_request_type
  end

  test 'PUT entity_types' do
    post :update, id: 'a0xxs00a-sx033', entity_type: entity_type_params
    assert_request_type
  end

  private

  def entity_type_params
    {"name": 'Entity Type 1', "description": 'a great entity type', "field_type": 'string', "client_integration_id": '1'}
  end

  def class_name
    GlobalRegistryModels::EntityType::EntityType
  end

end

require 'test_helper'

class RelationshipTypesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
    add_token
  end

  test "should not post when not signed in" do
    sign_out
    post :create
    assert_response 401
    assert_not_requested :post, "https://stage-api.global-registry.org/relationship_types"
  end

  test "should not be able to create when there is no token" do
    remove_token
    post :create
    assert_response 302
    assert_not_requested :post, "https://stage-api.global-registry.org/relationship_types"
  end

  test "should not be able to update when there is no token" do
    remove_token
    post :update, id: 'a0xxs00a-sx033'
    assert_response 302
    assert_not_requested :put, "https://stage-api.global-registry.org/relationship_types/a0xxs00a-sx033"
  end

  test 'POST relationship_types' do
    post(:create, relationship_type: relationship_params)
    assert_request_type
    assert_requested :post, "https://stage-api.global-registry.org/relationship_types"
  end

  test 'PUT relationship_types' do
    post(:update, id:'a0xxs00a-sx033', relationship_type: relationship_params)
    assert_request_type
    assert_requested :put, "https://stage-api.global-registry.org/relationship_types/a0xxs00a-sx033"
  end

  private

  def relationship_params
    {entity_type1_id: 'ss5sasxxs5', entity_type2_id: 'ss5sasxxs5', relationship1: 'father', relationship2: 'son'}
  end

  def class_name
    GlobalRegistryModels::RelationshipType::RelationshipType
  end

end
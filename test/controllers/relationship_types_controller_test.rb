require 'test_helper'

class RelationshipTypesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should not post when not signed in" do
    sign_out
    post :create
    assert_response 401
    assert_not_requested :post, "https://stage-api.global-registry.org/relationship_types"
  end

  test 'POST relationship_types' do
    post(:create, relationship_type: relationship_params)
    assert_request_type
  end

  test 'PUT relationship_types' do
    post(:update, id:'a0xxs00a-sx033', relationship_type: relationship_params)
    assert_request_type
  end

  private

  def relationship_params
    {entity_type1_id: 'ss5sasxxs5', entity_type2_id: 'ss5sasxxs5', relationship1: 'father', relationship2: 'son'}
  end

  def class_name
    GlobalRegistryModels::RelationshipType::RelationshipType
  end

end
require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    sign_in users(:one)
    add_token
  end

  test "should not get index when not signed in" do
    sign_out
    get :index
    assert_response 401
    assert_not_requested :get, "https://stage-api.global-registry.org/subscriptions"
  end

  test "should not get index without token" do
    remove_token
    get :index
    assert_response 302
    assert_not_requested :get, "https://stage-api.global-registry.org/subscriptions"
  end

  test "should not create without token" do
    remove_token
    post :create
    assert_response 302
    assert_not_requested :post, "https://stage-api.global-registry.org/subscriptions"
  end

  test "should not destroy subscription" do
    remove_token
    delete :destroy, id: "0000-0000-0001"
    assert_response 302
    assert_not_requested :delete, "https://stage-api.global-registry.org/subscriptions/0000-0000-0001"
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert assigns[:entity_types].all.size > 1
    assert_instance_of GlobalRegistryModels::EntityType::EntityType, assigns[:entity_types].first
  end

  test "should create subscription" do
    post :create, subscription: { entity_type_id: "0000-00023-00", endpoint: "http://test.host" }
    assert_requested :post, "https://stage-api.global-registry.org/subscriptions", body: '{"subscription":{"entity_type_id":"0000-00023-00","endpoint":"http://test.host"}}'
    assert_redirected_to subscriptions_path
  end

  test "should destroy subscription" do
    delete :destroy, id: "0000-0000-0001"
    assert_requested :delete, "https://stage-api.global-registry.org/subscriptions/0000-0000-0001"
    assert_redirected_to subscriptions_path
  end
end

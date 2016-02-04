require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

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

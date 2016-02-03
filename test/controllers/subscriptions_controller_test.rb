require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @subscription = subscriptions(:one)
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
    assert_difference('Subscription.count') do
      post :create, subscription: { entity_type_id: @subscription.entity_type_id }
    end
    assert_redirected_to subscription_path(assigns(:subscription))
  end

  test "should destroy subscription" do
    assert_difference('Subscription.count', -1) do
      delete :destroy, id: @subscription
    end
    assert_redirected_to subscriptions_path
  end
end

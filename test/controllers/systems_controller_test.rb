require 'test_helper'

class SystemsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_requested :get, "https://stage-api.global-registry.org/systems"
    assert_not_nil assigns(:systems)
    assert_not_nil assigns(:system_of_user)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:system_of_user)
  end

  test "should create system" do
    post :create, system: { contact_email: "test@email.com", contact_name: "Mr test", name: "test system", permalink: "test.com" }
    assert_requested :post, "https://stage-api.global-registry.org/systems", body: '{"system":{"name":"test system","contact_name":"Mr test","contact_email":"test@email.com","permalink":"test.com"}}'
    assert_redirected_to systems_path
  end

  test "should show system" do
    get :show, id: "0000-0000-0000-0001"
    assert_response :success
    assert_not_nil assigns(:system_of_user)
    assert_requested :get, "https://stage-api.global-registry.org/systems/0000-0000-0000-0001"
  end

  test "should get edit" do
    get :edit, id: "0000-0000-0000-0001"
    assert_response :success
    assert_not_nil assigns(:system_of_user)
    assert_requested :get, "https://stage-api.global-registry.org/systems/0000-0000-0000-0001"
  end

  test "should update system" do
    patch :update, id: "0000-0000-0000-0001", system: { contact_email: "test@email.com", contact_name: "Mr test", name: "test system", permalink: "test.com" }
    assert_requested :put, "https://stage-api.global-registry.org/systems/0000-0000-0000-0001", body: '{"system":{"name":"test system","contact_name":"Mr test","contact_email":"test@email.com","permalink":"test.com"}}'
    assert_redirected_to systems_path
  end

   test "should reset access_token" do
    post :reset_token, reset_token: { system_id: "0000-0000-0000-0001" }
    assert_requested :post, "https://stage-api.global-registry.org/systems/reset_access_token?id=0000-0000-0000-0001"
    assert_redirected_to edit_system_path("0000-0000-0000-0001")
  end

end

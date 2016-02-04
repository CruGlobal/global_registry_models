require 'test_helper'

class SystemsControllerTest < ActionController::TestCase
  setup do
    @system = systems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system" do
    assert_difference('System.count') do
      post :create, system: { contact_email: @system.contact_email, contact_name: @system.contact_name, name: @system.name, permalink: @system.permalink }
    end

    assert_redirected_to system_path(assigns(:system))
  end

  test "should show system" do
    get :show, id: @system
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system
    assert_response :success
  end

  test "should update system" do
    patch :update, id: @system, system: { contact_email: @system.contact_email, contact_name: @system.contact_name, name: @system.name, permalink: @system.permalink }
    assert_redirected_to system_path(assigns(:system))
  end

  test "should destroy system" do
    assert_difference('System.count', -1) do
      delete :destroy, id: @system
    end

    assert_redirected_to systems_path
  end
end

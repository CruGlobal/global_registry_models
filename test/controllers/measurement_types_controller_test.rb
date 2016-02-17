require 'test_helper'

class MeasurementTypesControllerTest < ActionController::TestCase
  def setup
    sign_in users(:one)
    add_token
  end

  test "should not post when not signed in" do
    sign_out
    post :create
    assert_response 401
    assert_not_requested :post, "https://stage-api.global-registry.org/measurement_types"
  end

  test "should not be able to create when there is no token" do
    remove_token
    post :create
    assert_response 302
    assert_not_requested :post, "https://stage-api.global-registry.org/measurement_types"
  end

  test "should not be able to update when there is no token" do
    remove_token
    patch :update, id: 'ss0066sx'
    assert_response 302
    assert_not_requested :put, "https://stage-api.global-registry.org/measurement_types/ss0066sx"
  end

  test 'POST measurement_types' do
    post(:create, measurement_type: measurement_type_params)
    assert_requested :post, "https://stage-api.global-registry.org/measurement_types"
    assert_request_type
  end

  test 'PUT measurement_types' do
    post(:update, id: 'ss0066sx', measurement_type: measurement_type_params)
    assert_requested :put, "https://stage-api.global-registry.org/measurement_types/ss0066sx"
    assert_request_type
  end

  private

  def measurement_type_params
    { name: "New Staff", perm_link: "LMI", description: "A description", frequency: "1", unit: "people", related_entity_type_id: "12sdasda12" }
  end

  def class_name
    GlobalRegistryModels::MeasurementType::MeasurementType
  end
end
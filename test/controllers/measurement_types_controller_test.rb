require 'test_helper'

class MeasurementTypesControllerTest < ActionController::TestCase
  def setup
    sign_in users(:one)
  end

  test "should not post when not signed in" do
    sign_out
    post :create
    assert_response 401
    assert_not_requested :post, "https://stage-api.global-registry.org/measurement_types"
  end

  test 'POST measurement_types' do
    post(:create, measurement_type: measurement_type_params)
    assert_request_type
  end

  test 'PUT measurement_types' do
    post(:update, id: 'ss0066sx', measurement_type: measurement_type_params)
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
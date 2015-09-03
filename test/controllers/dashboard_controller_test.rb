require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

  test 'response 401 when not signed' do
    get :index
    assert_response 401
  end

  test 'response 200 when signed in' do
    sign_in users(:one)
    get :index
    assert_response 200
    assert_equal users(:one), assigns[:current_user]
  end

end

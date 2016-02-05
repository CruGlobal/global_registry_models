require 'test_helper'

class AccessTokensControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end

  test "should update system" do
    patch :update, id: 1, access_token: { token: "A00XXSCVSX" }
    assert_equal "A00XXSCVSX", cookies[:access_token]
    assert_redirected_to root_url
  end

end

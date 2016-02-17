require 'test_helper'

class AccessTokensControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
    add_token
  end

  test "should not get edit when not signed in" do
    sign_out
    get :edit
    assert_response 401
    assert_not_requested :get, "https://stage-api.global-registry.org/access_tokens/edit"
  end

  test "should get edit" do
    get :edit, id: 1
    assert_response :success
  end

  test "should update the access token" do
    patch :update, access_token: { token: "A00XXSCVSX" }
    assert_equal "A00XXSCVSX", cookies[:access_token]
    assert_redirected_to root_url
  end

  test "should redirect if bad token" do
    patch :update, access_token: { token: "BAD_TOKEN" }
    assert_not_nil flash[:error]
    assert_redirected_to access_tokens_edit_path
  end

end

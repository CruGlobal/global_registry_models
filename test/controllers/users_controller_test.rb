require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test "should not get index when not signed in" do
    sign_out
    get :index
    assert_response 401
    assert_not_requested :get, "https://stage-api.global-registry.org/users"
  end

  test 'GET :index' do
    get :index
    assert_response :success
    assert assigns[:users].present?
  end

  test 'GET :new' do
    get :new
    assert_response :success
  end

  test 'POST :create with guid' do
    assert_difference 'User.count', 1 do
      post :create, user: { guid: 'g-u-i-d' }
    end
    assert_redirected_to users_path
  end

  test 'POST :create with email' do
    assert_difference 'User.count', 1 do
      post :create, user: { email: 'example@email.com' }
    end
    assert_redirected_to users_path
  end

  test 'GET :edit' do
    get :edit, id: users(:one)
    assert_response :success
  end

  test 'PUT :update' do
    assert_no_difference 'User.count' do
      put :update, id: users(:one).id, user: { guid: 'new-guid' }
    end
    assert_redirected_to users_path
    assert_equal 'new-guid', users(:one).reload.guid
  end

  test 'DELETE :destroy' do
    assert_difference "User.where(id: #{ users(:one).id }).count", -1 do
      delete :destroy, id: users(:one)
    end
    assert_redirected_to users_path
  end
end

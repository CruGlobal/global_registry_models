require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)

    stub_request(:get, "https://thekey.me/cas/api/test/user/attributes?theKeyGuid=g-u-i-d")
      .with(headers: { 'Accept' => 'application/json'})
      .to_return(status: 200, body: %({"relayGuid":"8F612500-0000-541D-FC38-2AF75974729F","ssoGuid":"8F612500-0000-541D-FC38-2AF75974729F","firstName":"Test","lastName":"User","theKeyGuid":"g-u-i-d","email":"bob@internet.com"}), headers: {})

    stub_request(:get, "https://thekey.me/cas/api/test/user/attributes?email=example@email.com").
    with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
    to_return(status: 200, body: %({"relayGuid":"8F612500-0000-541D-FC38-2AF75974729F","ssoGuid":"8F612500-0000-541D-FC38-2AF75974729F","firstName":"Test","lastName":"User","theKeyGuid":"g-u-i-d","email":"bob@internet.com"}), headers: {})

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

  test 'DELETE :destroy' do
    assert_difference "User.where(id: #{ users(:one).id }).count", -1 do
      delete :destroy, id: users(:one)
    end
    assert_redirected_to users_path
  end
end

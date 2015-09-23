require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'GET new' do
    get :new
    assert_response :success
  end

  test 'GET new redirects to root_path if already signed in' do
    sign_in users(:one)
    get :new
    assert_redirected_to root_path
  end

  test 'POST create' do
    post :create
    assert_redirected_to root_path
  end

  test 'DELETE destroy' do
    delete :destroy
    assert_redirected_to '/logout'
  end

end

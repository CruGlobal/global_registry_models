require 'test_helper'

class TestController < ApplicationController
  before_filter :authenticate_user, only: :test_authenticate_user_action

  def test_authenticate_user_action
    head :ok
  end
end

class ApplicationControllerTest < ActionController::TestCase
  tests TestController

  def with_test_routing
    with_routing do |map|
      map.draw do
        get 'test_authenticate_user_action' => 'test#test_authenticate_user_action'
      end

      yield
    end
  end

  test '#authenticate_user responds with 401 when not signed-in' do
    with_test_routing do
      get :test_authenticate_user_action
      assert_response 401
      assert_nil assigns['current_user']
      assert_nil session['cas']
    end
  end

  test '#authenticate_user responds with 200 when signed-in' do
    with_test_routing do
      sign_in users(:one)
      get :test_authenticate_user_action
      assert_response 200
      assert_equal users(:one), assigns['current_user']
      assert_equal 'user-one-guid-5197-11E5-B6A3-3087D5902334', session['cas']['extra_attributes']['theKeyGuid']
    end
  end

  test '#authenticate_user finds existing user after successful sign-in' do
    with_test_routing do
      sign_in users(:one)
      assert_no_difference 'User.count' do
        get :test_authenticate_user_action
      end
      assert_response 200
      assert_equal users(:one), assigns['current_user']
      assert assigns['current_user'].persisted?
    end
  end

  test '#authenticate_user creates a new user after successful sign-in' do
    with_test_routing do
      new_user = User.new email: 'new@user.com', first_name: 'New', last_name: 'User', guid: 'new-user-guid'
      sign_in new_user
      assert_difference 'User.count', 1 do
        get :test_authenticate_user_action
      end
      assert_response 200
      assert assigns['current_user'].persisted?
      assert_equal 'new@user.com', assigns['current_user'].email
      assert_equal 'New', assigns['current_user'].first_name
      assert_equal 'User', assigns['current_user'].last_name
      assert_equal 'new-user-guid', assigns['current_user'].guid
    end
  end

  test '#update_current_user_from_cas_session after_successful_authentication' do
    with_test_routing do
      sign_in users(:one)
      session['cas']['user'] = 'new@email.com'
      session['cas']['extra_attributes']['firstName'] = 'Newfirstname'
      session['cas']['extra_attributes']['lastName'] = 'Newlastname'
      get :test_authenticate_user_action
      assert_response 200
      users(:one).reload
      assert_equal users(:one), assigns['current_user']
      assert_equal users(:one).email, 'new@email.com'
      assert_equal users(:one).first_name, 'Newfirstname'
      assert_equal users(:one).last_name, 'Newlastname'
    end
  end
end

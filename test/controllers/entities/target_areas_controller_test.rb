require 'test_helper'

class Entities::TargetAreasControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test 'GET index' do
    get :index
    assert_response :success
    assert assigns[:target_areas].all.size > 1
  end

  test 'GET index with filters' do
    get :index, filters: { name: 'test' }
    assert_response :success
    assert assigns[:target_areas].all.size > 1
  end

  test 'GET show' do
    get :show, id: '219A7C20-58B8-11E5-B850-6BAC9D6E46F5'
    assert_response :success
    assert_equal '219A7C20-58B8-11E5-B850-6BAC9D6E46F5', assigns[:target_area].id
  end

end

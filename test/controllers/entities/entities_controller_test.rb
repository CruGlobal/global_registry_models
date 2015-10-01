require 'test_helper'

class Entities::EntitiesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  test 'GET index' do
    get :index, entity_class: Entity::Test.name.pluralize
    assert_response :success
    assert assigns[:entities].all.size > 1
    assert_equal Entity::Test, assigns[:entity_class]
    assert_equal 1, assigns[:page]
  end

  test 'GET index with invalid entity class' do
    get :index, entity_class: 'wut'
    assert_redirected_to root_path
    assert_nil assigns[:entity_class]
  end

  test 'GET index with filters' do
    get :index, entity_class: Entity::Test.name.pluralize, filters: { name: 'test' }
    assert_response :success
    assert assigns[:entities].all.size > 1
    assert_equal 1, assigns[:page]
  end

  test 'GET index with page' do
    get :index, entity_class: Entity::Test.name.pluralize, page: 2
    assert_response :success
    assert assigns[:entities].all.size > 1
    assert_equal 2, assigns[:page]
  end

  test 'GET show' do
    get :show, entity_class: Entity::Test.name.pluralize, id: '219A7C20-58B8-11E5-B850-6BAC9D6E46F5'
    assert_response :success
    assert_equal '219A7C20-58B8-11E5-B850-6BAC9D6E46F5', assigns[:entity].id
    assert_equal Entity::Test, assigns[:entity_class]
  end

end

require 'test_helper'

class ExportCsvsControllerTest < ActionController::TestCase

  def setup
    request.env['HTTP_REFERER'] = root_path
  end

  test 'response 401 when not signed' do
    post :create
    assert_response 401
  end

  test 'POST create' do
    sign_in users(:one)
    post :create, entity_class_name: 'target_area', filters: 'test', email: 'email.me@test.com'
    assert_redirected_to root_path
    assert flash[:error].blank?
  end

  test 'POST create invalid params' do
    sign_in users(:one)
    post :create
    assert_redirected_to root_path
    assert flash[:error].present?
  end

end

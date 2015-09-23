require 'test_helper'

class ExportCsvsControllerTest < ActionController::TestCase

  def setup
    request.env['HTTP_REFERER'] = root_path
  end

  test 'POST create' do
    post :create, entity_type: 'target_area', filters: 'test', email: 'email.me@test.com'
    assert_redirected_to root_path
    assert flash[:error].blank?
  end

  test 'POST create invalid params' do
    post :create
    assert_redirected_to root_path
    assert flash[:error].present?
  end

end

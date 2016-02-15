require 'test_helper'
class WebControllerTest < ActionDispatch::IntegrationTest
  
  test 'GET sidekiq ui page should not be available to all' do
    assert_raise(ActionController::RoutingError) {
      get "/sidekiq"
    } 
  end

end

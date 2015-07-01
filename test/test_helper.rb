ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride'
require 'minitest/mock'
require 'webmock/minitest'

# Don't allow any external network requests, use stubs instead (see gem webmock).
WebMock.disable_net_connect! allow_localhost: true

# Requires supporting ruby files with stubs, etc.
Dir[Rails.root.join('test/support/**/*.rb')].each { |f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

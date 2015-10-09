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

  def sign_in(user)
    session['cas'] ||= {}
    session['cas']['user'] = user.email
    session['cas']['extra_attributes'] ||= {}
    session['cas']['extra_attributes']['theKeyGuid'] = user.guid
    session['cas']['extra_attributes']['firstName'] = user.first_name
    session['cas']['extra_attributes']['lastName'] = user.last_name
  end

end

# A Test model that we'll use to test entities
module GlobalRegistryModels
  module Entity
    class Test < GlobalRegistryModels::Entity::Base
      attribute :id, String
      attribute :phone, String
      attribute :name, String
    end
  end
end

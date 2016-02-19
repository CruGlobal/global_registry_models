$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'global_registry'
require 'global_registry_models'

require 'minitest/autorun'
require 'webmock/minitest'

# Don't allow any external network requests, use stubs instead (see gem webmock).
WebMock.disable_net_connect! allow_localhost: true

# Requires supporting ruby files, stubs, etc.
require File.expand_path('../support/stubs/global_registry_stubs', __FILE__)

GlobalRegistry.access_token = 'test'
GlobalRegistry.base_url = 'https://test-api.global-registry.org/'

# A Test model that we'll use to test entities
module GlobalRegistryModels
  module Entity
    class Test < Base
      attribute :id, String
      attribute :phone, String
      attribute :name, String
      attribute :is_active, Boolean
    end

    class SlowTest < Base
    end
  end
end


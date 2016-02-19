require 'test_helper'

class GlobalRegistryModelsRetryerTest < Minitest::Test

  def test_new
    retryer = GlobalRegistryModels::Retryer.new
    assert_instance_of GlobalRegistryModels::Retryer, retryer
    assert_equal [StandardError], retryer.exception_classes
  end

  def test_try
    silence_stream(STDOUT) do
      response = GlobalRegistryModels::Retryer.new(RuntimeError, RestClient::InternalServerError, max_attempts: 2).try do
        slow_entity_test_response
      end
    end
  rescue RuntimeError
    assert_requested :get, 'https://test-api.global-registry.org/entities?entity_type=slow_test', times: 2
  end

  private

  def slow_entity_test_response
    GlobalRegistry::Entity.get entity_type: 'slow_test'
  end
end
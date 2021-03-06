require 'test_helper'

class GlobalRegistryModelsSubscriptionSubscriptionTest < Minitest::Test

  def test_new
    subscription_params={
      "entity_type_id": "672fbfc0-e0e6-11e3-8f08-12725f8f377c",
      "endpoint": "test.com"
    }
    subscription = GlobalRegistryModels::Subscription::Subscription.new(subscription_params)
    assert_instance_of GlobalRegistryModels::Subscription::Subscription, subscription
    assert_equal "672fbfc0-e0e6-11e3-8f08-12725f8f377c", subscription.entity_type_id
    assert_equal "test.com", subscription.endpoint
  end

end

## Subscriptions Helper
module SubscriptionsHelper
  def entity_type_name(entity_type_id)
    @entity_types.find { |entity_type| entity_type.id == entity_type_id }.try(:name)
  end
end

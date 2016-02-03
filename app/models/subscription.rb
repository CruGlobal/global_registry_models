class Subscription < ActiveRecord::Base
  validates :entity_type_id, presence: true
end

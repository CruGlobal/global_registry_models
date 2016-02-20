module GlobalRegistryModels
  module Subscription
    class Base < CommonBase

      def self.search_params
        {}
      end

      def self.global_registry_resource
        GlobalRegistry::Subscription
      end

      def self.attributes_hash(attributes)
        { 
          'subscription' => attributes 
        }
      end

    end
  end
end
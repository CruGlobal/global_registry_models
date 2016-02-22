# A base class providing CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

module GlobalRegistryModels
  module Entity
    class Base < CommonBase
      attribute :client_integration_id, String
      validates_presence_of :client_integration_id
      def self.search_params
        {
          entity_type: name
        }
      end

      def self.global_registry_resource
        GlobalRegistry::Entity
      end

      def self.attributes_hash(attributes)
        {'entity'.to_sym => { name => attributes }}
      end

      # The name of the entity class. The entity name is required in the api responses and requests, hence the need for this class method.
      def self.name
        to_s.gsub(/.*::/, '').underscore
      end

      def self.default_field
        '*'
      end
    end
  end
end

# A base class providing CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

module GlobalRegistryModels
  module Entity
    class Base < CommonBase
      attribute :client_integration_id, String
      validates_presence_of :client_integration_id

      def initialize(params = {})
        super(params)
        @relationships = []
        params.each do |key,value|
          create_relationship(key,value) if key.to_s.include? ':relationship'
        end
      end

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

      def relationships
        @relationships
      end

      def self.specific_attributes_preparations(object, attributes)
        object.relationships.each do |relationship|
          attributes["#{relationship.relationship_type}:relationship"] = {
            relationship.entity_type => relationship.related_entity_id,
            'client_integration_id' => relationship.client_integration_id
          }
        end
        attributes
      end

      private

      def create_relationship(key,value_hash)
        @relationships << Relationship.new(relationship_type: key.to_s.split(':').first, entity_type: value_hash.keys.first,
                                           related_entity_id: value_hash.values.first, client_integration_id: value_hash['client_integration_id'])
      end
    end
  end
end

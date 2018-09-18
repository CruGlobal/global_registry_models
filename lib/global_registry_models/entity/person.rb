module GlobalRegistryModels
  module Entity
    class Person < Base
      attribute :first_name, String
      attribute :last_name, String
      attribute :gsw_access, Boolean
      attribute :key_guid, String
      attribute :global_leader, Boolean

      def initialize(params)
        super
        self.key_guid = params['authentication'] && params['authentication']['key_guid'] unless self.key_guid
      end

      def to_s
        [first_name, last_name].compact.join(' ')
      end

      private

      def self.specific_attributes_preparations(object, attributes)
        attributes = super(object, attributes)
        attributes['authentication'] = {'key_guid' => attributes['key_guid']} if attributes['key_guid']
        attributes.delete('key_guid')
        attributes
      end
    end
  end
end

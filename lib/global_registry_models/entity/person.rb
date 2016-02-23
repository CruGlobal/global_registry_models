module GlobalRegistryModels
  module Entity
    class Person < Base
      attribute :first_name, String
      attribute :last_name, String
      attribute :gsw_access, Boolean
      attribute :key_guid, String

      def initialize(params)
        super
        self.key_guid = params['authentication'] && params['authentication']['key_guid']
      end

      def to_s
        [first_name, last_name].compact.join(' ')
      end
    end
  end
end

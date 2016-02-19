require 'global_registry_models/entity/authentication'
module GlobalRegistryModels
  module Entity
    class Person < Base
      attribute :first_name, String
      attribute :last_name, String
      attribute :gsw_access, Boolean
      attribute :authentication, Authentication

      def to_s
        [first_name, last_name].compact.join(' ')
      end
    end
  end
end

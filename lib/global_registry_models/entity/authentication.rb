module GlobalRegistryModels
  module Entity
    class Authentication < Base
      attribute :key_guid, String

      def to_s
        key_guid
      end
    end
  end
end

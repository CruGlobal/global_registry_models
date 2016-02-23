module GlobalRegistryModels
  module Entity
    class EnumValueBase < Base
      include GlobalRegistryModels::APIOperations::AddEnumValue
      attribute :enum_value, String

      def initialize(enum_value)
        self.enum_value = enum_value
      end

      def self.identifying_attributes
        [:enum_value]
      end

      def to_s
        enum_value
      end
    end
  end
end

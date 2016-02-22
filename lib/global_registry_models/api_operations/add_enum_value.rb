module GlobalRegistryModels
  module APIOperations
    module AddEnumValue
      extend ActiveSupport::Concern

      module ClassMethods
        def add_enum_value(entity_type_name, enum_value)
          hash = { 'entity' => { '_enum_values' => { entity_type_name => enum_value } } }
          GlobalRegistry::Entity.post(hash)
        end
      end
    end
  end
end
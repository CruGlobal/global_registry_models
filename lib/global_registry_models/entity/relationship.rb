module GlobalRegistryModels
  module Entity
    class Relationship < Base
      attribute :relationship_type, String
      attribute :entity_type, String
      attribute :related_entity_id, String
      attribute :relationship_entity_id, String

      def self.identifying_attributes
        [:name, :description, :is_editable, :field_type, :data_visibility, :parent_id]
      end

    end
  end
end

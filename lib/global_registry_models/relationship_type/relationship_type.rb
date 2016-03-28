module GlobalRegistryModels
  module RelationshipType
    class RelationshipType < Base
      attribute :id, String
      attribute :entity_type1_id
      attribute :entity_type2_id
      attribute :relationship1
      attribute :relationship2
      attribute :relationship_entity_type_id

      validates_presence_of :entity_type1_id, :relationship1, :entity_type2_id, :relationship2

      def initialize(params = {})
        super(params)
        create_involved_types([params["relationship1"],params["relationship2"]]) if params["relationship1"] && params["relationship2"] && !params["entity_type1_id"]
      end

      def involved_types
        @involved_types
      end

      private

      def create_involved_types relationships
        @involved_types=[]
        relationships.each do |relationship|
          @involved_types << InvolvedType.new(relationship)
        end
      end

    end
  end
end

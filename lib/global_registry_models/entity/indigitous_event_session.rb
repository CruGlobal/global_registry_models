module GlobalRegistryModels
  module Entity
    class IndigitousEventSession < Base
      attribute :date, Date
      attribute :title, String
      attribute :webinar_id, String
      attribute :language, String
      attribute :registered, Integer
      attribute :attended, Integer
      
      def self.identifying_attributes
        [:title, :date, :attended]
      end

      def to_s
        title
      end
    end
  end
end

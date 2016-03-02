module GlobalRegistryModels
  module Entity
    class IndigitousEventHash < Base
      attribute :date, Date
      attribute :city, String
      attribute :country, String
      attribute :days, Integer
      attribute :local_lead, String
      attribute :number_attended, Integer
      
      def self.identifying_attributes
        [:city, :date, :number_attended]
      end

      def to_s
        "#{city} #{date.to_s}"
      end
    end
  end
end

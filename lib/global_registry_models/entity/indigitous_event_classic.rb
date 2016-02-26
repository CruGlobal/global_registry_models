module GlobalRegistryModels
  module Entity
    class IndigitousEventClassic < Base
      attribute :city, String
      attribute :date, String
      attribute :full_attendees, Integer
      attribute :day_pass_attendees, Integer
      attribute :nations, Integer
      attribute :organizations, Integer
      attribute :projects, Integer
      
      def self.identifying_attributes
        [:city, :date, :full_attendees]
      end

      def to_s
        "#{city} #{date}"
      end
    end
  end
end

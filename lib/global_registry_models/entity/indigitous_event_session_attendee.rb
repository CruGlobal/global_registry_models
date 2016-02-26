module GlobalRegistryModels
  module Entity
    class IndigitousEventSessionAttendee < Base
      attribute :attended, Boolean
      attribute :interest_rating, Integer
      attribute :last_name, String
      attribute :first_name, String
      attribute :email_address, String
      attribute :registration_date, Date
      attribute :time_in_session, String
      
      def self.identifying_attributes
        [:attended, :first_name, :last_name]
      end

      def to_s
        "#{first_name} #{last_name}"
      end
    end
  end
end

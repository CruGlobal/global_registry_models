module GlobalRegistryModels
  module Entity
    class TargetArea < Base
      attribute :abbrv, String
      attribute :address1, String
      attribute :address2, String
      attribute :alt_name, String
      attribute :city, String
      attribute :country, String
      attribute :email, String
      attribute :enrollment, Integer
      attribute :event_id, Integer
      attribute :event_type, String
      attribute :fax, String
      attribute :fice, String
      attribute :gate, String
      attribute :highest_offering, String
      attribute :institution_type, String
      attribute :is_closed, String
      attribute :is_global_slm_team_target, Boolean
      attribute :is_no_fice_ok, String
      attribute :is_secure, Boolean
      attribute :latitude, Float
      attribute :longitude, Float
      attribute :main_campus_fice, String
      attribute :name, String
      attribute :note, String
      attribute :ongoing_special_event, Boolean
      attribute :phone, String
      attribute :region, String
      attribute :state, String
      attribute :target_area_ministry_presence, String
      attribute :type, String
      attribute :url, String
      attribute :zip, String
      attribute :google_place_id, String
      attribute :google_map_url, String

      def self.identifying_attributes
        [:name, :country, :state]
      end

      def self.writeable_attributes
        super - [:gate, :highest_offering, :institution_type, :is_closed]
      end

      def to_s
        name
      end
    end
  end
end

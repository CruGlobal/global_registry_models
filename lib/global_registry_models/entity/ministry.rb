module GlobalRegistryModels
  module Entity
    class Ministry < Base
      attribute :abbreviation, String
      attribute :address1, String
      attribute :address2, String
      attribute :city, String
      attribute :country, String
      attribute :currency_code, String
      attribute :currency_symbol, String
      attribute :dataserver_url, String
      attribute :dta, String
      attribute :fiscal_start_month, Integer
      attribute :gma_status, String
      attribute :has_ds, Boolean
      attribute :has_gcm, Boolean
      attribute :has_llm, Boolean
      attribute :has_slm, Boolean
      attribute :is_active, Boolean
      attribute :is_fcx, Boolean
      attribute :is_secure, Boolean
      attribute :lane, String
      attribute :last_dataserver_donation, String
      attribute :last_dataserver_transaction, String
      attribute :last_financial_report, String
      attribute :lmi_hide, String
      attribute :lmi_show, String
      attribute :location, String
      attribute :location_zoom, Integer
      attribute :logo_url, String
      attribute :measurement_status, String
      attribute :min_code, String
      attribute :ministry_brand, String
      attribute :ministry_scope, String
      attribute :ministry_type, String
      attribute :name, String
      attribute :note, String
      attribute :phone, String
      attribute :registered_name, String
      attribute :sp_phone, String
      attribute :stage, Integer
      attribute :stage_2020_goal, String
      attribute :stage_progress_target_month, String
      attribute :stage_progress_target_year, String
      attribute :state, String
      attribute :url, String
      attribute :url_facebook_page, String
      attribute :url_twitter, String
      attribute :url_instagram, String
      attribute :zip, String
      attribute :is_slm_secure, Boolean

      def self.identifying_attributes
        [:name, :country, :city, :min_code]
      end

      def to_s
        name
      end
    end
  end
end

module Entity
  class IsoCountry < Base
    attribute :currency_code, String
    attribute :currency_name, String
    attribute :currency_symbol, String
    attribute :iso2_code, String
    attribute :iso3_code, String
    attribute :name, String

    def self.identifying_attributes
      [:name, :iso2_code, :iso3_code]
    end

    def to_s
      name
    end
  end
end

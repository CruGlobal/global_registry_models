module Entity
  class GlobalMcc < Base
    attribute :mcc_code, String
    attribute :name, String
    attribute :partner_md_total, Integer

    def self.identifying_attributes
      [:name, :mcc_code]
    end

    def to_s
      name
    end
  end
end

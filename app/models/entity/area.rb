module Entity
  class Area < Base
    attribute :area_code, String
    attribute :area_name, String
    attribute :is_active, Boolean

    def self.identifying_attributes
      [:area_name, :area_code]
    end

    def to_s
      area_name
    end
  end
end


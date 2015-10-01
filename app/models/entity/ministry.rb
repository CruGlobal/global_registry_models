module Entity
  class Ministry < Base
    attribute :country, String
    attribute :city, String
    attribute :is_active, String
    attribute :location, String
    attribute :min_code, String
    attribute :name, String
    attribute :ministry_type, String

    def self.identifying_attributes
      [:name, :country, :city, :min_code]
    end

    def to_s
      name
    end
  end
end



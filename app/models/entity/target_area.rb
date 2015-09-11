module Entity
  class TargetArea < Base
    attribute :name, String
    attribute :country, String
    attribute :region, String
    attribute :state, String
    attribute :city, String
    attribute :enrollment, Integer
    attribute :address1, String
    attribute :address2, String
    attribute :zip, String
    attribute :url, String
    attribute :note, String
    attribute :latitude, Float
    attribute :longitude, Float
    attribute :is_global_slm_team_target, String
    attribute :type, String
    attribute :target_area_ministry_presence, String

    def to_s
      name
    end
  end
end

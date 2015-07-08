module Entity
  class TargetArea < Base
    has_attributes :name, :country, :region, :state, :city, :enrollment, :address1, :address2, :zip, :url, :note, :latitude, :longitude, :is_global_slm_team_target, :type, :target_area_ministry_presence

    def enrollment=(new_enrollment)
      @enrollment = new_enrollment.to_i if new_enrollment.present?
    end

    def latitude=(new_latitude)
      @latitude = new_latitude.to_f if new_latitude.present?
    end

    def longitude=(new_longitude)
      @longitude = new_longitude.to_f if new_longitude.present?
    end

  end
end

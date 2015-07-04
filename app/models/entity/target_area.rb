module Entity
  class TargetArea < Base
    has_attributes :id, :client_integration_id, :name, :country, :region, :state, :city, :enrollment, :address1, :address2, :zip, :url, :note, :latitude, :longitude, :is_global_slm_team_target
  end
end

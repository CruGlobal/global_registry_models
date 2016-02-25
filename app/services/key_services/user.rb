module KeyServices
  class User
    def initialize(email: nil, guid: nil)
      @email = email
      @guid = guid
    end

    def cas_attributes
      response = RestClient.get(
        ENV['CAS_URL'] + "/cas/api/#{ENV['CAS_ACCESS_TOKEN']}/user/attributes?#{format_present_attribute}",
        accept: :json
      )
      JSON.parse(response)
      # Sample output
      # {"relayGuid"=>"F167605D-94A4-7121-2A58-8D0F2CA6E026",
      #  "ssoGuid"=>"F167605D-94A4-7121-2A58-8D0F2CA6E026",
      #  "firstName"=>"Joshua",
      #  "lastName"=>"Starcher",
      #  "theKeyGuid"=>"F167605D-94A4-7121-2A58-8D0F2CA6E026",
      #  "email"=>"josh.starcher@cru.org"}
    end

    private

    def format_present_attribute
      @email.present? ? "email=#{@email}" : "theKeyGuid=#{@guid}"
    end
  end
end

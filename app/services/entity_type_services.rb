require 'securerandom'
## Services related to entity types
module EntityTypeServices
  ## Class that generates a uuid
  class Uuid
    def initialize
      @uuid = SecureRandom.uuid
    end

    def to_s
      @uuid
    end
  end
end

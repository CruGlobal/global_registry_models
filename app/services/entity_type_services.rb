require 'securerandom'

module EntityTypeServices
  class Uuid

    def initialize
      @uuid = SecureRandom.uuid
    end

    def to_s
      @uuid
    end

  end
end
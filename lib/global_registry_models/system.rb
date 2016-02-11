## A class method to retrieve current system
module GlobalRegistryModels
  module System
    class System < Base
      def self.find_current_system
        find 'deadbeef-dead-beef-dead-beefdeadbeef'
      end
    end
  end
end

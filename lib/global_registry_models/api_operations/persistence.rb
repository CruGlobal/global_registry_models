module GlobalRegistryModels
  module APIOperations
    module Persistence
      extend ActiveSupport::Concern

      module ClassMethods

        def ressource_type
           global_registry_resource.to_s.demodulize.underscore
        end

        def create!(attributes)
          object = new(attributes.with_indifferent_access.except(:id))
          if object.valid?
            attribute_keys_to_create = attributes.keys.collect(&:to_sym) & writeable_attributes
            create_attributes = object.attributes.with_indifferent_access.slice(*attribute_keys_to_create)
            response = global_registry_resource.post(attributes_hash(create_attributes))
            if response.present?
              response_hash = response[ressource_type] 
              response_hash.has_key?(name) ? (new response_hash[name]) : (new response_hash)
            end
          else
            raise GlobalRegistryModels::RecordInvalid.new
          end
        end

        def create(attributes)
          create! attributes
        rescue GlobalRegistryModels::RecordInvalid
          false
        end

        def update!(id, attributes)
          object = new(attributes)
          if object.valid?
            attribute_keys_to_update = attributes.keys.collect(&:to_sym) & writeable_attributes
            update_attributes = object.attributes.with_indifferent_access.slice(*attribute_keys_to_update)
            response_hash = global_registry_resource.put(id, attributes_hash(update_attributes))[ressource_type]
            response_hash.has_key?(name) ? (new response_hash[name]) : (new response_hash)
          else
            raise GlobalRegistryModels::RecordInvalid.new
          end
        end

        def update(id, attributes)
          update! id, attributes
        rescue GlobalRegistryModels::RecordInvalid
          false
        end

      end

      def save
        if valid?
          result = id.present? ? self.class.update(id, attributes) : self.class.create(attributes)
          result ? self.id = result.id : false
        else
          false
        end
      end

      def update!(update_attributes)
        self.class.update! id, { client_integration_id: client_integration_id }.with_indifferent_access.merge(update_attributes)
      end
    end
  end
end


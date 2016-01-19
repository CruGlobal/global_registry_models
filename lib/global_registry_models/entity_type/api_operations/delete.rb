module GlobalRegistryModels
  module EntityType
    module APIOperations
      module Delete
        extend ActiveSupport::Concern

        module ClassMethods
          def delete(id)
            GlobalRegistry::Entity.delete id
          end
        end

        def delete
          if id.present?
            self.class.delete id
          else
            false
          end
        end

      end
    end
  end
end

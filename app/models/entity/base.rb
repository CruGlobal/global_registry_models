# A base class providing basic ActiveModel-ish CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

module Entity
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    include Virtus.model

    include Entity::Base::Finders
    include Entity::Base::Search

    attribute :id, String
    attribute :client_integration_id, String

    validates_presence_of :client_integration_id

    def self.attribute_names
      attribute_set.collect(&:name)
    end

    def self.create(attributes)
      attributes = attributes.except(:id)
      if new(attributes).valid?
        new GlobalRegistry::Entity.post({ entity: { name => attributes }})['entity'][name]
      else
        false
      end
    end

    def self.update(id, attributes)
      attributes = attributes.except(:id)
      if new(attributes).valid?
        new GlobalRegistry::Entity.put(id, { entity: { name => attributes }})['entity'][name]
      else
        false
      end
    end

    def self.delete(id)
      GlobalRegistry::Entity.delete id
    end

    # The name of the entity class. The entity name is required in the api responses and requests, hence the need for this class method.
    def self.name
      to_s.gsub(/.*::/, '').underscore
    end

    def delete
      if id.present?
        self.class.delete id
      else
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

  end
end

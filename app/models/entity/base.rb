module Entity
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations

    REQUIRED_ATTRIBUTES = [:id, :client_integration_id]

    validates_presence_of :client_integration_id

    def initialize(attributes = {})
      super attributes.with_indifferent_access.slice(*self.class.attribute_names)
    end

    def self.has_attributes(*attrs)
      raise "#{ self } attributes were already defined!" if respond_to? :attribute_names

      attrs = (attrs + REQUIRED_ATTRIBUTES).uniq

      attr_accessor *attrs

      define_singleton_method(:attribute_names) { attrs.collect(&:to_sym) }

      define_method :attributes do
        self.class.attribute_names.each_with_object({}) { |attr, hash| hash[attr] = self.send(attr) }
      end

      define_method :assign_attributes do |new_attribute_values = {}|
        new_attribute_values.each do |attribute_name, attribute_value|
          self.send("#{ attribute_name }=", attribute_value) if self.class.attribute_names.include?(attribute_name.to_sym)
        end
      end
    end

    def self.find(id)
      new GlobalRegistry::Entity.find(id)['entity'][name]
    end

    def self.page(page_number = 1)
      GlobalRegistry::Entity.get(entity_type: name, page: page_number)['entities'].collect { |entity| new(entity[name]) }
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
        result ? self.assign_attributes(result.attributes) : false
      else
        false
      end
    end

  end
end

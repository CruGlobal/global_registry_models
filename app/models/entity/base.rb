# A base class providing basic ActiveModel-ish CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

module Entity
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations

    REQUIRED_ATTRIBUTES = [:id, :client_integration_id]

    validates_presence_of :client_integration_id

    def initialize(attributes = {})
      super attributes.with_indifferent_access.slice(*self.class.attribute_names)
    end

    # This method should be called once in the child class to define the attributes that we need on the entity.
    # It defines a few methods we'll need for working with attributes.
    def self.has_attributes(*attrs)
      raise "#{ self } attributes were already defined!" if respond_to? :attribute_names

      # Require some attributes for all entities.
      attrs = (attrs + REQUIRED_ATTRIBUTES).uniq

      # Define basic reader and writers for the attributes.
      attr_accessor *attrs

      # attribute_names is a class method that returns the attributes on this class.
      define_singleton_method(:attribute_names) { attrs.collect(&:to_sym) }

      # Define attributes instance method that returns a hash with the the attributes and their current values.
      define_method :attributes do
        self.class.attribute_names.each_with_object({}) { |attr, hash| hash[attr] = self.send(attr) }
      end

      # Defines assign_attributes instance method that can assign all the attributes to new values from a hash of attributes.
      define_method :assign_attributes do |new_attribute_values = {}|
        new_attribute_values.each do |attribute_name, attribute_value|
          self.send("#{ attribute_name }=", attribute_value) if self.class.attribute_names.include?(attribute_name.to_sym)
        end
      end
    end

    def self.search(filters: {}, page: nil, per_page: nil, order: nil)
      params = {
        entity_type: name,
        page: page,
        per_page: per_page,
        order: order
      }.delete_if { |k, v| v.blank? }

      # We need to generate a hash like this: { 'filters[name]' => 'name query', 'filters[attribute][nested_attribute]' => 'nested_attribute query' }
      # It just so happens we can use CGI::parse to do it.
      filter_params_hash = CGI::parse({ filters: filters }.to_query)
      filter_params_hash.each { |k, v| filter_params_hash[k] = v.first if v.is_a?(Array) } # CGI::parse returns values as arrays, we just want string values

      params.merge! filter_params_hash

      GlobalRegistry::Entity.get(params)['entities'].collect { |entity| new(entity[name]) }
    end

    def self.find(id)
      new GlobalRegistry::Entity.find(id)['entity'][name]
    end

    def self.page(page_number = 1)
      search page: page_number
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
        result ? self.assign_attributes(result.attributes) : false
      else
        false
      end
    end

  end
end

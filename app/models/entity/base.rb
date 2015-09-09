# A base class providing basic ActiveModel-ish CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

module Entity
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    include Virtus.model

    attribute :id, String
    attribute :client_integration_id, String

    validates_presence_of :client_integration_id

    def self.attribute_names
      attribute_set.collect(&:name)
    end

    def self.search(filters: nil, page: nil, per_page: nil, order: nil, fields: nil, ruleset: nil)
      params = {
        entity_type: name,
        page: page,
        per_page: per_page,
        order: order,
        fields: fields,
        ruleset: ruleset
      }.delete_if { |_, v| v.blank? }

      if filters.present?
        filters.reject! { |_, v| v.blank? }
        # We need to generate a hash like this: { 'filters[name]' => 'name query', 'filters[attribute][nested_attribute]' => 'nested_attribute query' }
        # It just so happens we can use CGI::parse to do it.
        filter_params_hash = CGI::parse({ filters: filters }.to_query)
        filter_params_hash.each { |k, v| filter_params_hash[k] = v.first if v.is_a?(Array) } # CGI::parse returns values as arrays, we just want string values

        params.merge! filter_params_hash
      end

      response = ::GlobalRegistryResponseParser.new GlobalRegistry::Entity.get(params)
      Entity::Collection.new meta: response.meta, entities: response.entities
    end

    def self.all!(filters: nil, start_page: 1, per_page: nil, order: nil, fields: nil, ruleset: nil)
      [].tap do |all_entities|
        page_num = start_page
        loop do
          print '.'
          collection_of_entities = Retryer.only_on([RestClient::InternalServerError]).forever do
            search(filters: filters, page: page_num, per_page: per_page, order: order, fields: filters, ruleset: ruleset)
          end
          break if collection_of_entities.all.blank?
          all_entities.concat collection_of_entities.all
          page_num += 1
        end
      end
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
        result ? self.id = result.id : false
      else
        false
      end
    end

  end
end

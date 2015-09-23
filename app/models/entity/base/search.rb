module Entity::Base::Search
  extend ActiveSupport::Concern

  module ClassMethods

    def search(filters: nil, page: nil, per_page: nil, order: nil, fields: nil, ruleset: nil)
      params = {
        entity_type: name,
        page: page,
        per_page: per_page,
        order: order,
        fields: fields,
        ruleset: ruleset
      }.delete_if { |_, v| v.blank? }

      filters.try(:reject!) { |_, v| v.blank? }
      if filters.present?
        # We need to generate a hash like this: { 'filters[name]' => 'name query', 'filters[attribute][nested_attribute]' => 'nested_attribute query' }
        # It just so happens we can use CGI::parse to do it.
        filter_params_hash = CGI::parse({ filters: filters }.to_query)
        filter_params_hash.each { |k, v| filter_params_hash[k] = v.first if v.is_a?(Array) } # CGI::parse returns values as arrays, we just want string values

        params.merge! filter_params_hash
      end

      response = ::GlobalRegistryResponseParser.new Retryer.new(RestClient::InternalServerError).try { GlobalRegistry::Entity.get(params) }
      Entity::Collection.new meta: response.meta, entities: response.entities
    end

  end
end

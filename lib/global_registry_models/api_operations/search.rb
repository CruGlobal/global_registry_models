module GlobalRegistryModels
  module APIOperations
     module Search
      extend ActiveSupport::Concern

      module ClassMethods
        
        def search(filters: nil, page: nil, per_page: nil, order: nil, fields: default_field, ruleset: nil)

          params = params_by_offset_and_limit(page, per_page) if requires_pagination?(page, per_page)

          params ||= search_params.merge({ 
            page: page,
            per_page: per_page,
            order: order,
            fields: fields,
            ruleset: ruleset
          }).delete_if { |_, v| v.blank? }

          params = clean_params(filters, params)
          response = GlobalRegistryModels::ResponseParser.new(global_registry_resource.get(params))

          meta, objects = extract_meta_and_objects(page, per_page, response)

          Collection.new meta: meta, list: objects 
        end

        def params_by_offset_and_limit(page, per_page)
          { 
            offset: offset(per_page, page),
            limit: per_page + 1
          }
        end

        def extract_meta_and_objects(page, per_page, response)
          return [response.meta, response.objects] unless requires_pagination?(page, per_page)
          meta = {
                    "page" => page.to_i,
                    "next_page" => next_page?(per_page, response.objects.count),
                    "from" => offset(per_page, page)+1,
                    "to" => offset(per_page, page).to_i + per_page
                  }
          objects = ( next_page?(per_page, response.objects.count) ? response.objects[0...-1] : response.objects )
          return [ meta, objects ]
        end

        def requires_pagination?(page, per_page)
          !has_meta && page && per_page
        end

        def offset(per_page, page)
          per_page.to_i * (page.to_i  - 1)
        end

        def next_page?(per_page, objects_count)
          per_page + 1 == objects_count
        end

        def clean_params( filters, params )
          filters.try(:reject!) { |_, v| v.blank? }
          if filters.present?
            # We need to generate a hash like this: { 'filters[name]' => 'name query', 'filters[attribute][nested_attribute]' => 'nested_attribute query' }
            # It just so happens we can use CGI::parse to do it.
            filter_params_hash = CGI::parse({ filters: filters }.to_query)
            filter_params_hash.each { |k, v| filter_params_hash[k] = v.first if v.is_a?(Array) } # CGI::parse returns values as arrays, we just want string values

            params.merge! filter_params_hash
          end

          params
        end

      end

    end
  end
end

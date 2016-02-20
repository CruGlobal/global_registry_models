require 'active_support'
require 'global_registry'
require 'global_registry_models/retryer'

module GlobalRegistryModels
  module APIOperations
    module Finders
      extend ActiveSupport::Concern

      module ClassMethods

        def all!(filters: nil, start_page: 1, per_page: nil, order: nil, fields: '*', ruleset: nil, max_attempts: 1)
          GlobalRegistryModels::Collection.new(meta: {}, list: []).tap do |collection|
            page_num = start_page
            loop do
              sub_collection = GlobalRegistryModels::Retryer.new(RuntimeError, RestClient::InternalServerError, max_attempts: max_attempts).try do
                self.search(filters: filters, page: page_num, per_page: per_page, order: order, fields: fields, ruleset: ruleset)
              end
              collection.concat sub_collection.all
              page_num += 1
              break if sub_collection.blank? || sub_collection.last_page?
            end
          end
        end

        def find(id)
          response_hash = global_registry_resource.find(id)[ressource_type]
          response_hash.has_key?(name) ? (new response_hash[name]) : (new response_hash)
        end

        def page(page_number = 1)
          search page: page_number
        end

      end
    end
  end
end

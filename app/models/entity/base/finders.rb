require 'retryer'

module Entity::Base::Finders
  extend ActiveSupport::Concern

  module ClassMethods

    def all!(filters: nil, start_page: 1, per_page: nil, order: nil, fields: nil, ruleset: nil)
      Entity::Collection.new(meta: {}, entities: []).tap do |collection|
        page_num = start_page
        loop do
          sub_collection = Retryer.new(RestClient::InternalServerError).try do
            self.search(filters: filters, page: page_num, per_page: per_page, order: order, fields: fields, ruleset: ruleset)
          end
          break if sub_collection.blank?
          collection.concat sub_collection.all
          page_num += 1
        end
      end
    end

    def find(id)
      new GlobalRegistry::Entity.find(id)['entity'][name]
    end

    def page(page_number = 1)
      search page: page_number
    end

  end
end

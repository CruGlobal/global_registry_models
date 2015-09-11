module Entity::Base::Finders
  extend ActiveSupport::Concern

  module ClassMethods

    def all!(filters: nil, start_page: 1, per_page: nil, order: nil, fields: nil, ruleset: nil)
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

    def find(id)
      new GlobalRegistry::Entity.find(id)['entity'][name]
    end

    def page(page_number = 1)
      search page: page_number
    end

  end
end

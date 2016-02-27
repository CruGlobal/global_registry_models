# A base class providing CRUD for GlobalRegistry Entities.
# API doc at https://github.com/CruGlobal/global_registry_docs/wiki/Entities

require 'active_model'
require 'virtus'

module GlobalRegistryModels
  class CommonBase

    include ActiveModel::Model
    include ActiveModel::Validations
    include ActiveModel::Validations::Callbacks
    include Virtus.model

    include GlobalRegistryModels::APIOperations::Persistence
    include GlobalRegistryModels::APIOperations::Finders
    include GlobalRegistryModels::APIOperations::Search
    include GlobalRegistryModels::APIOperations::Delete

    attribute :id, String
    
    def self.title
      name.titleize
    end

    def self.attribute_names
      attribute_set.collect(&:name)
    end

    def self.filterable_attributes
      attribute_names - [:id]
    end

    def self.identifying_attributes
      [:id]
    end

    def self.writeable_attributes
      attribute_names - [:id]
    end

    def self.default_field
      nil
    end

    def self.has_meta
      true
    end

    private

    def underscore_name
      self.name = self.name.downcase.tr(' ','_') if self.name
    end

    def self.specific_attributes_preparations(object, attributes)
      attributes
    end

  end

end

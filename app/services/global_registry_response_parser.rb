class GlobalRegistryResponseParser

  def initialize(global_registry_response)
    @response_hash = global_registry_response
  end

  def meta
    @response_hash['meta']
  end

  def entities
    @entities ||= build_entities
  end

  private

    def build_entities
      @response_hash['entities'].collect(&:flatten).collect do |entity_type, entity_attributes|
        entity_class(entity_type).new(entity_attributes)
      end
    end

    def entity_class(entity_type_string)
      "Entity::#{ entity_type_string.classify }".constantize
    end
end

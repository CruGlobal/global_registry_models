module EntityTypesHelper

  def display_relationships(entity_type)
    relationships_html = ""
    entity_type.relationships && entity_type.relationships.each do |relationship_type|
      f_i=relationship_type.involved_types.first
      s_i=relationship_type.involved_types.second
      relationships_html += "<h5 id='#{relationship_type.id}'> <p>#{f_i.entity_type}</p> <--- ( <p>#{f_i.relationship_name}</p> / <p>#{s_i.relationship_name}</p> ) ---> <p>#{s_i.entity_type}</p><a href='#'>Edit</a></h5>"
    end
    relationships_html != "" ? relationships_html.html_safe : "<h5>This entity type has no relationship types.</h5>".html_safe
  end

  def entity_type_class
    GlobalRegistryModels::EntityType::EntityType
  end

  def field_class
    GlobalRegistryModels::EntityType::Field
  end

  def field_descriptions(object)
    description=""
    object.fields && object.fields.each do |field|
      description+=render 'entity_types/field_details', field: field
      description+=field_descriptions field
    end
    description.html_safe
  end

end

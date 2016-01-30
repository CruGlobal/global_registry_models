module EntityTypesHelper

  def display_relationships(entity_type)
    relationships_html = ""
    entity_type.relationships && entity_type.relationships.each do |relationship_type|
      f_i=relationship_type.involved_types.first
      s_i=relationship_type.involved_types.second
      relationships_html += 
      "<h5 id='#{relationship_type.id}'> #{f_i.entity_type}<p style='display:none;'>#{find_id(f_i.entity_type)}</p> <--- ( <p>#{f_i.relationship_name}</p> /
       <p style='display:none;'>#{find_id(s_i.entity_type)}</p><p>#{s_i.relationship_name}</p> ) ---> #{s_i.entity_type}<a href='#'>Edit</a></h5>"
    end
    relationships_html != "" ? relationships_html.html_safe : "<h5>This entity type has no relationship types.</h5>".html_safe
  end

  def find_id(entity_type_name)
    @entity_types.find {|entity_type| entity_type.name == entity_type_name }.try(:id)
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

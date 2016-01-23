module EntityTypesHelper

  def display_relationships(entity_type)
    relationships_html = ""
    entity_type.relationships && entity_type.relationships.each do |relationship_type|
      f_i=relationship_type.involved_types.first
      s_i=relationship_type.involved_types.second
      relationships_html += "<h5> #{f_i.entity_type} <--- ( #{f_i.relationship_name} / #{s_i.relationship_name} ) ---> #{s_i.entity_type}</h5>"
    end
    relationships_html.html_safe if relationships_html != ""
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

## Entity types helper
module EntityTypesHelper
  def display_relationships(entity_type)
    relationships_html = ''
    entity_type.relationships && entity_type.relationships.each do |rel_type|
      f_i = rel_type.involved_types.first
      s_i = rel_type.involved_types.second
      relationships_html += build_string(rel_type, f_i, s_i)
    end
    if relationships_html != ''
      relationships_html.html_safe
    else
      '<h5>This entity type has no relationship types.</h5>'.html_safe
    end
  end

  def find_id(entity_type_name)
    @entity_types.find { |entity_type| entity_type.name == entity_type_name }.try(:id)
  end

  def entity_type_class
    GlobalRegistryModels::EntityType::EntityType
  end

  def field_class
    GlobalRegistryModels::EntityType::Field
  end

  def measurement_type_class
    GlobalRegistryModels::MeasurementType::MeasurementType
  end

  def field_descriptions(object)
    description = ''
    object.fields && object.fields.each do |field|
      description += render 'entity_types/field_details', field: field
      description += field_descriptions field
    end
    description.html_safe
  end

  def already_there?(field_id)
    @entity_types.any? { |entity_type| entity_type.id == field_id }
  end

  def build_string(rel_type, f_i, s_i)
    "<h5 id='description-#{rel_type.id}'>
    #{f_i.entity_type}
    <p style='display:none;'>#{find_id(f_i.entity_type)}</p>
    <--- ( <p>#{f_i.relationship_name}</p> /
    <p style='display:none;'>#{find_id(s_i.entity_type)}</p>
    <p>#{s_i.relationship_name}</p> ) --->
    #{s_i.entity_type}
    <a href='#'>Edit</a></h5>"
  end
end

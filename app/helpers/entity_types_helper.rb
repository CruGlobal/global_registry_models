module EntityTypesHelper

  def display_relationships(entity_type)
    relationships_html = ""
    @relationship_types.all.find_all {|relationship_type| relationship_type.involved_types.any? {|involved| involved.entity_type == entity_type.name} }.each do |relationsip_type|
      f_i=relationsip_type.involved_types.first
      s_i=relationsip_type.involved_types.second
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

end

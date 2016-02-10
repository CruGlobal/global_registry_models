## Application helper
module ApplicationHelper
  def flash_type_to_bootstrap_class(type)
    case type.to_s
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'warning'
      'warning'
    else
      'info'
    end
  end

  def entities
    [
      GlobalRegistryModels::Entity::Area,
      GlobalRegistryModels::Entity::GlobalMcc,
      GlobalRegistryModels::Entity::IsoCountry,
      GlobalRegistryModels::Entity::Ministry,
      GlobalRegistryModels::Entity::TargetArea
    ]
  end

  def titleize_attribute(attribute_name)
    attribute_name.to_s.tr('_', ' ').titleize
    # Preserves 'id' for attributes ending with '_id'
  end

  def form_attribute_to_field(form_name, attribute, object)
    unless attribute == :id || attribute == :access_token
      name = "#{form_name}[#{attribute}]"
      val = object.send(attribute) if object
      val = val.join(', ') if val.is_a?(Array)
      content_tag(:div, class: 'form-group') do
        "#{label_tag(attribute)} #{correct_form(attribute, name, val)}"
      end
    end
  end

  def correct_form(attribute, name, val)
    case attribute
    when :is_editable, :root
      select name, val, [false, true], {}, class: 'form-control'
    when :data_visibility
      select name, val, %w(public private), {}, class: 'form-control'
    when :description
      text_area_tag name, val, class: 'form-control'
    when :trusted_ips
      text_field_tag name, val, id: 'tokenfield', class: 'form-control'
    when :name, :related_entity_type, :frequency, :perm_link, :unit
      text_field_tag name, val, class: 'form-control', required: true
    else
      text_field_tag name, val, class: 'form-control'
    end
  end
end

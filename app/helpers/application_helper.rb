## Application helper
module ApplicationHelper
  FIELD_TYPES = %w(boolean date datetime decimal email enum_values float integer string text uuid).freeze

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
    unless [:id, :access_token].include? attribute
      name = "#{form_name}[#{attribute}]"
      val = object.send(attribute) if object
      val = val.join(', ') if val.is_a?(Array)
      content_tag(:div, class: 'form-group') do
        "#{correct_label(attribute)} #{correct_field(attribute, name, val)}".html_safe
      end
    end
  end

  # rubocop:disable MethodLength, CyclomaticComplexity
  def correct_field(attribute, name, val)
    case attribute
    when :is_editable, :root
      select_tag name, options_for_select([true, false]), selected: val, class: 'form-control'
    when :data_visibility
      select_tag name, options_for_select(%w(public private)), selected: val, class: 'form-control'
    when :field_type
      select_tag name, options_for_select(FIELD_TYPES), selected: val, class: 'form-control'
    when :description
      text_area_tag name, val, class: 'form-control'
    when :trusted_ips
      text_field_tag name, val, id: 'tokenfield', class: 'form-control'
    when :name, :related_entity_type, :frequency, :perm_link, :unit
      text_field_tag name, val, class: 'form-control', required: true
    when :parent_id
      hidden_field_tag name, val
    else
      text_field_tag name, val, class: 'form-control'
    end
  end
  # rubocop:enable MethodLength, CyclomaticComplexity

  def correct_label(attribute)
    label_tag(attribute) unless attribute == :parent_id
  end
end

module EntitiesHelper

  def filters_text_field_tag(name:, label:)
    safe_join [
      label_tag(label),
      text_field_tag("filters[#{ name }]", params[:filters].try(:[], name), placeholder: label, class: 'form-control')
    ]
  end

end

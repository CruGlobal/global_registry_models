## Entities Helpers
module EntitiesHelper
  def filters_text_field_tag(name:, label:)
    safe_join [
      label_tag("filters[#{name}]", label, class: 'control-label col-sm-4 text-right'),
      content_tag(:div, text_field_tag("filters[#{name}]", params[:filters].try(:[], name),
                                       placeholder: label, class: 'form-control'), class: 'col-sm-8')
    ]
  end
end

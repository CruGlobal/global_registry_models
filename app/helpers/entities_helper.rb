## Entities Helpers
module EntitiesHelper
  def filters_text_field_tag(name:, label:)
    safe_join [
      label_tag("filters[#{name}]", label, class: 'control-label col-sm-4 text-right'),
      content_tag(:div, text_field_tag("filters[#{name}]", params[:filters].try(:[], name),
                                       placeholder: label, class: 'form-control'), class: 'col-sm-8')
    ]
  end

  def paginate_collection(collection)
    content_tag :ul, class: 'pagination' do
      list = []
      list << page_tag('previous', collection) unless collection.first_page?
      list << page_tag('next', collection) unless collection.last_page?
      safe_join list
    end
  end

  def page_tag(type, collection)
    content_tag(:li, link_to(t("views.pagination.#{type}").html_safe,
                             params.tap { |p| p[:page] = go_to_page(type, collection) }))
  end

  def go_to_page(type, collection)
    type == 'previous' ? collection.previous_page : collection.next_page
  end
end

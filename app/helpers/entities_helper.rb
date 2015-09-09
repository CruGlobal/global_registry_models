module EntitiesHelper

  def filters_text_field_tag(name:, label:)
    safe_join [
      label_tag(label),
      text_field_tag("filters[#{ name }]", params[:filters].try(:[], name), placeholder: label, class: 'form-control')
    ]
  end

  def paginate_entity_collection(entity_collection)
    content_tag :ul, class: 'pagination' do
      list = []
      list << content_tag(:li, link_to(t('views.pagination.previous').html_safe, params.tap { |p| p[:page] = entity_collection.prev_page })) unless entity_collection.first_page?
      list << content_tag(:li, link_to(t('views.pagination.next').html_safe, params.tap { |p| p[:page] = entity_collection.next_page })) unless entity_collection.last_page?
      safe_join list
    end
  end

end

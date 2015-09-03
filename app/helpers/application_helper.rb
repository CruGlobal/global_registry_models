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

end

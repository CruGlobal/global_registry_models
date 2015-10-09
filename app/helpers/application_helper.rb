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

end

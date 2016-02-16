## Systems Helper
module SystemsHelper
  include PaginationHelper

  def system_class
    GlobalRegistryModels::System::System
  end

  def formatted_value(attribute)
    f_value = @system.send attribute
    f_value = f_value.join(', ') if f_value.is_a?(Array)
    f_value
  end

  def relevant_attributes
    relevant_attributes = system_class.identifying_attributes unless root_user?
    relevant_attributes = system_class.identifying_root_attributes if root_user?
    relevant_attributes
  end

  def root_user?
    @system_of_user.root
  end

  def system_owner?
    @system_of_user == @system
  end

  def can_edit?(system)
    root_user? || @system_of_user == system
  end
end

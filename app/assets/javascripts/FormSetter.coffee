 
class window.FormSetter
  constructor: (params = {}) ->
    @mode     = params.mode or 'Create new'
    @ressource     = params.ressource or 'Entity Type'
    @modal_location = "##{@ressource.replace(" ","")}Modal"
    @url = "#{@ressource.replace(" ","_")}s".toLowerCase()
    @parent_id = params.click_context.parent().attr("id") if params.click_context
    @entity_type_id = params.entity_type_id
    @form_groups = "#{@modal_location} form .form-group"
    @enum_values_field_location = "#{@form_groups}:last"
    @editing_id = (if @is_edit() then @parent_id.replace('description-','/') else '')

  is_edit: ->
    @mode == "Edit" 

  open_and_customize: ->
    $("#{@modal_location}").modal('show')
    $("#{@modal_location} h4.modal-title").html("#{@mode} #{@ressource}")
    $("#{@modal_location} form").attr("action", "#{@url}#{@editing_id}")

  add_values: ->
    if @is_edit()
      form_groups = @form_groups
      $("##{@parent_id} p").each (index, elem) ->
        form_group = "#{form_groups}:nth-of-type(#{index+1})"
        $("#{form_group} input, #{form_group} select, #{form_group} textarea").val(elem.innerHTML.trim())
    else
      $("#{@form_groups} input[type='text']").val("")
      if @ressource == 'Relationship Type' || @ressource == 'Measurement Type'
        $("#{@form_groups}:first select, #{@form_groups}:first input").val(@parent_id.replace('description-',''))

  fix_enum_values: ->
    if $("#{@form_groups}:nth-of-type(4) select").val() == "enum_values"
      enum_value_field = "#{@enum_values_field_location} input"
      $(enum_value_field).tokenfield('destroy')
      $("#{@enum_values_field_location} label").html("Enum Values: #{$(enum_value_field).val()}")
      $(enum_value_field).val('')
      $(enum_value_field).tokenfield()
      $(@enum_values_field_location).show()
    else
      $(@enum_values_field_location).hide()

  add_parent_id: ->
    $("#{@form_groups}:nth-last-of-type(2) input").val(@entity_type_id)

  build: ->
    @open_and_customize()
    @add_values()
    @fix_enum_values() if @ressource == 'Entity Type'
    @add_parent_id() if @entity_type_id


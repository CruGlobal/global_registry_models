Turbolinks.enableProgressBar()

jQuery ->
  $(document).on "ready page:load", ->
    $('.accordion_button').click -> 
      if $(this).html()=='+'
        $(this).html('-')
      else
        $(this).html('+')

    $('.entity_type_name').click ->
      $('.panel-body').hide()
      $('#description'+$(this).attr('id')).show()
      measurement_container_path = "#description#{$(this).attr('id')} .measurment_types_container"
      if $("#{measurement_container_path} h4").length
        pull_measurement_type($(this).attr('id').substring(1), measurement_container_path)

    $('.panel-body a').click ->
      new FormBuilder({mode: "Edit", click_context: $(this)}).build()

    $('button#create_new').click ->
      new FormBuilder().build()

    $('a.new_field_link').click ->
      new FormBuilder({entity_type_id: $(this).attr("id")}).build()

  pull_measurement_type = (entity_type_id, measurement_container_path) ->
    $.ajax
      url: "/entity_types/#{entity_type_id} /measurement_types"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        console.log "AJAX Error: #{errorThrown}"
      success: (data) ->
        measurement_types = ""
        $.each data, (index, result) ->
          measurement_types += "<h5>#{result.name}</h5>"
        $(measurement_container_path).html(measurement_types)
        $(measurement_container_path).html("<h5>This entity type has no measurement types.</h5>") if measurement_types == ""




  class FormBuilder
    constructor: (params = {}) ->
      @mode     = params.mode or 'Create new'
      @ressource     = params.ressource or 'Entity Type'
      @modal_location = params.modal_location or '#editEntityTypeModal'
      @parent_id = params.click_context.parent().attr("id") if params.click_context
      @entity_type_id = params.entity_type_id
      @form_groups = "#{@modal_location} form .form-group"
      @enum_values_field_location = "#{@form_groups}:last"

    editing_id: ->
      if @is_edit() then @parent_id.replace('description-','') else ""

    is_edit: ->
      @mode == "Edit" 

    open_and_customize: ->
      $("#{@modal_location}").modal('show')
      $("#{@modal_location} h4.modal-title").html("#{@mode} #{@ressource}")
      $("#{@modal_location} form").attr("action", "entity_types#{@editing_id}")

    add_values: ->
      if @is_edit()
        form_groups = @form_groups
        $("##{@parent_id} p").each (index, elem) ->
          $("#{form_groups}:nth-of-type(#{index+1}) input").val(elem.innerHTML.trim())
      else
        $("#{@form_groups} input[type='text']").val("")

    fix_enum_values: ->
      if $("#{@form_groups}:nth-of-type(4) input").val() == "enum_values" 
        $("#{@enum_values_field_location} input").tokenfield('destroy')
        $(@enum_values_field_location).show()
        $("#{@enum_values_field_location} input").tokenfield()
      else
        $(@enum_values_field_location).hide()

    add_parent_id: ->
      $("#{@form_groups}:nth-last-of-type(2) input").val(@entity_type_id)

    build: ->
      @open_and_customize()
      @add_values()
      @fix_enum_values() if @ressource == 'Entity Type'
      @add_parent_id() if @entity_type_id








    



            
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
      set_edit_modal("Edit", $(this))

    $('button#create_new').click ->
      set_edit_modal("Create New", $(this))

    $('a.new_field_link').click ->
      set_edit_modal("Create New", $(this), $(this).attr('id'))

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

  set_edit_modal = (mode, thisObj, entity_type_id) ->
    $('#editModal').modal('show')
    $("h4.modal-title").html("#{mode} Entity Type")
    parent_id = thisObj.parent().attr('id') if is_edit(mode)
    editing_id = (if is_edit(mode) then  "/#{parent_id.replace('description-','')}" else "")
    $("form").attr("action", "entity_types#{editing_id}")
    form_location = "form#edit_entity_type .form-group"
    enum_values_field_location = "#{form_location}:last"
    if is_edit(mode)
      $("##{parent_id} p").each (index, elem) ->
        $("#{form_location}:nth-of-type(#{index+1}) input").val(elem.innerHTML.trim())
    else
      $("#{form_location} input[type='text']").val("")
      $("#{form_location}:nth-of-type(6) input").val(entity_type_id) if entity_type_id

    $("#{enum_values_field_location} input").tokenfield('destroy')

    if $("#{form_location}:nth-of-type(4) input").val() == "enum_values"
      $(enum_values_field_location).show()
      $("#{enum_values_field_location} input").tokenfield()
    else
      $(enum_values_field_location).hide()


  is_edit = (mode) ->
    mode == "Edit"



            
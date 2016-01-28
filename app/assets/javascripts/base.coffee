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
      measurement_container_path = "#description#{$(this).attr('id')} .measurment_type_container"
      if $("#{measurement_container_path} h4").length
        pull_measurement_type($(this).attr('id').substring(1), measurement_container_path)

    $('.panel-body a').click ->
      set_edit_modal("Edit", $(this))

    $('button#create_new').click ->
      set_edit_modal("Create New", $(this))

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

  set_edit_modal = (mode, thisObj) ->
    $('#editModal').modal('show')
    $("h4.modal-title").html("#{mode} Entity Type")
    parent_id = thisObj.parent().attr('id') if is_edit(mode)
    editing_id = (if is_edit(mode) then  "/#{parent_id.replace('description-','')}" else "")
    $("form").attr("action", "entity_types#{editing_id}")
    if is_edit(mode)
      $("##{parent_id} p").each (index, elem) ->
        $("form .form-group:nth-of-type(#{index+1}) input").val( elem.innerHTML.trim())
    else
      $("form .form-group input[type='text']").val("")

  is_edit = (mode) ->
    mode == "Edit"



            
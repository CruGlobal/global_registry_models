Turbolinks.enableProgressBar()

$(document).on "ready page:load", ->
  $('.accordion_button').click -> 
    if $(this).html()=='+'
      $(this).html('-')
    else
      $(this).html('+')

  $('.entity_type_name').click ->
    $('.panel-body').hide()
    $('#description'+$(this).attr('id')).show()
    measurement_container_path = "#description#{$(this).attr('id')} .measurement_types_container"
    if $("#{measurement_container_path} h4").length
      pull_measurement_type($(this).attr('id').substring(1), measurement_container_path)

  $('.panel-body a.edit_details').click ->
    new FormSetter({mode: "Edit", click_context: $(this)}).build()

  $('button#create_new').click ->
    new FormSetter().build()

  $('a.new_field_link').click ->
    new FormSetter({entity_type_id: $(this).attr("id")}).build()

  $('.relationship_types_container h5 a').click ->
    new FormSetter({mode: 'Edit', ressource: 'Relationship Type', click_context: $(this)}).build()

  $('.panel-body a.add_relationship_type').click ->
    new FormSetter({ressource: 'Relationship Type', click_context: $(this)}).build()

  $('.panel-body a.add_measurement_type').click ->
    new FormSetter({ressource: 'Measurement Type', click_context: $(this)}).build()

pull_measurement_type = (entity_type_id, measurement_container_path) ->
  $.ajax
    url: "/entity_types/#{entity_type_id} /measurement_types"
    dataType: "json"
    error: (jqXHR, textStatus, errorThrown) ->
      console.log "AJAX Error: #{errorThrown}"
    success: (data) ->
      measurement_types = ""
      $.each data, (index, result) ->
        measurement_types += "<h5 id='description-#{result.id}'>#{result.name}<a href='#'>Edit</a>"
        $.each result, (i, col) ->
          measurement_types += "<p>#{col}</p>"
        measurement_types+="</h5>"
      $(measurement_container_path).html(measurement_types)
      $(measurement_container_path).html("<h5>This entity type has no measurement types.</h5>") if measurement_types == ""
      $("#{measurement_container_path} h5 a").click ->
        new FormSetter({mode: 'Edit', ressource: 'Measurement Type', click_context: $(this)}).build()









    



            
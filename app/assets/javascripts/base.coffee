Turbolinks.enableProgressBar()

jQuery ->
  $(document).on "ready page:load", ->
    $('.accordion_button').click -> 
      if $(this).html()=='+'
        $(this).html('-')
      else
        $(this).html('+')

    $('.entity_type_name').click ->
      $('.description_panel').hide()
      $('#description'+$(this).attr('id')).show()
      measurement_container_path = '#description'+$(this).attr('id')+' .measurment_type_container'
      if ($(measurement_container_path+' h4').length)
        pull_measurement_type($(this).attr('id').substring(1),measurement_container_path)

    pull_measurement_type = (entity_type_id,measurement_container_path) ->
      $.ajax
        url: "/entity_types/"+entity_type_id+"/measurement_types"
        dataType: "json"
        error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{errorThrown}"
        success: (data) ->
          measurement_types = ''
          $.each data, (index,result) ->
            measurement_types += '<h4>'+result.name+'</h4>'
          $(measurement_container_path).html(measurement_types)


            
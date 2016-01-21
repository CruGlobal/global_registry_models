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
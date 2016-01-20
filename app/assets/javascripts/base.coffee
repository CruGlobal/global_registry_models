Turbolinks.enableProgressBar()

jQuery ->
  $(document).on "ready page:load", ->
    $('.accordion_button').click -> 
      $(this).html('-')

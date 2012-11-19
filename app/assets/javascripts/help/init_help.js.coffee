@init_help = () ->
  help_link = $('.help a')
  help_box = $('.help_box')

  $(document).keyup (e) ->
    if (e.keyCode == 27)
      help_link.removeClass('clicked')
      help_box.hide()

  $('body').on 'click', ->
    help_link.removeClass('clicked')
    help_box.hide()

  help_link.on 'click', (evt) ->
    target = $(evt.target)
    target.toggleClass('clicked')

    help_box.toggle()

    false

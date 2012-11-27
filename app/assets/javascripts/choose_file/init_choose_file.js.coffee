@remove_file = (wrapper, input, link) ->
  wrapper.find('.remove_file').on 'click', ->
    input.val('')
    wrapper.find('.link').remove()
    if wrapper.find('.choose_file').length
      link.show()
    else
      link.appendTo(wrapper)
      init_choose_file()
    false

@init_choose_file = () ->
  $('.choose_file').on 'click', (evt) ->
    link = $(evt.target)
    wrapper = link.parent()
    params = link.parent().find('input').attr('params')
    dialog = link.create_or_return_dialog('elfinder_picture_dialog')
    input  = link.parent().find('input')
    origin_id = input.attr('id')

    dialog.attr('id_data', origin_id)
    dialog.load_iframe(params)

    input.change ->
      file_url = input.val()
      link.hide()
      $('.link', wrapper).remove()
      wrapper.prepend('<a href='+file_url+' class="link">Скачать файл ('+decodeURI(file_url.match(/([^\/]+\.\w+)$/)[1])+')</a><a href="#" class="remove_file link">Удалить</a>')
      remove_file(wrapper, input, link)
      input.unbind('change')

    false

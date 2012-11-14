cancel_handler = () ->
  $('.cancel').on 'click', ->
    link = $(this)
    if link.hasClass('new_record')
      link.closest('.ajaxed_item').remove()
    false

@init_ajaxed = () ->
  $(".ajaxed").on "ajax:success", (evt, response, status, jqXHR) ->
    target = $(evt.target)
    ul = target.siblings("ul")
    if target.hasClass('new_record')
      ul.append(jqXHR.responseText)
    else
      target.closest('.ajaxed_item').replaceWith(jqXHR.responseText)

    cancel_handler()

    if $('.remove_file').length
      remove_link = $('.remove_file')
      upload_link = $('<a href="#" class="choose_file">Выбрать файл</a>').hide()
      remove_link.after(upload_link)

      remove_file(
        remove_link.parent('.add_file_wrapper'),
        remove_link.siblings('.input').children('input'),
        upload_link
      )

    init_choose_file() if $('.choose_file').length

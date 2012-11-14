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

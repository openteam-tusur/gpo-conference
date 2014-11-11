$.fn.show_loader_for = (content) ->
  target = $(this)
  target.addClass('show_loader')
  setTimeout ->
    target.removeClass('show_loader').html(content)
  ,
    800
  target

cancel_handler = () ->
  $('.cancel').on 'click', ->
    link = $(this)
    if link.hasClass('new_record')
      link.closest('ul').siblings('.new_comment').show()
      link.closest('.ajaxed_item').remove()
    false

@init_ajaxed = () ->
  $(".ajaxed").on "ajax:success", (evt, response, status, jqXHR) ->
    target = $(evt.target)
    ul = target.siblings("ul")

    if target.hasClass('new_record')
      if ul.length
        ul.append(jqXHR.responseText)
      else
        parent = target.closest('.ajaxed')
        parent.show_loader_for(jqXHR.responseText)

      if target.hasClass('new_comment')
        $('form.new_comment .cancel').click()
        target.hide()
    else
      target.closest('ul').siblings('.new_comment').show() unless $(jqXHR.responseText).find('.error').length
      target.closest('.ajaxed_item').replaceWith(jqXHR.responseText)

    cancel_handler()

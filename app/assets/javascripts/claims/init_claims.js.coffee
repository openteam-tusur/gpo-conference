@init_claims = () ->
  select = $("#claim_project_id").hide()
  selected_option = $("option[selected=selected]", select)
  label = select.prev("label")
  label.attr("for", "claim_project_name")
  input = $("<input type=\"text\" name=\"claim[project_name]\" id=\"claim_project_name\" value=\"#{selected_option.text()}\"/>").insertBefore(select)
  projects = new Array
  $("option", select).each (index, item) ->
    projects.push( { id: $(this).val(), value: $(this).text() } ) if $(this).val().length
    true
  input.focus().autocomplete
    source: projects
    select: (event, ui) ->
      select.val(ui.item.id)
      true
  true

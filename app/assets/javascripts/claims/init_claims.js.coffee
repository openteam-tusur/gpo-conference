@init_claims = () ->
  select = $("#project_member_claim_project_id").hide()
  selected_option = $("option[selected=selected]", select)
  label = select.prev("label")
  label.attr("for", "project_member_claim_project_name")
  input = $("<input type=\"text\" name=\"project_member_claim[project_name]\" id=\"project_member_claim_project_name\" value=\"#{selected_option.text()}\"/>").insertBefore(select)
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

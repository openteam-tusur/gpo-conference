$ ->
  init_claims() if $("#project_member_claim_project_id").length
  init_ajaxed() if $(".ajaxed").length
  init_help()   if $('.help').length
  true

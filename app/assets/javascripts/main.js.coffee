$ ->
  init_claims() if $("#project_member_claim_project_id").length
  init_ajaxed() if $(".ajaxed").length
  true

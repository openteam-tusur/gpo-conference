class User
  include AuthClient::User

  def app_name
    'gpo_conference'
  end

  def claims
    @claims ||= Claim.where(:user_id => id)
  end

  def project_member_claims
    @project_member_claims ||= ProjectMemberClaim.where(:user_id => id)
  end

  def themes(conference)
    @themes ||= conference.themes.where(:id => permissions.where(:context_type => 'Theme').pluck(:context_id))
  end

  def rated_projects(conference)
    @rated_projects ||= themes(conference).flat_map(&:projects)
  end

  def rated_discourses(conference)
    @rated_discourses ||= rated_projects(conference).flat_map(&:discourses)
  end
end

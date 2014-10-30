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

  def themes
    @themes ||= Theme.where(:id => permissions.where(:context_type => 'Theme').pluck(:context_id))
  end

  def rated_projects
    @rated_projects ||= themes.flat_map(&:projects)
  end

  def rated_discourses
    @rated_discourses ||= rated_projects.flat_map(&:discourses)
  end
end

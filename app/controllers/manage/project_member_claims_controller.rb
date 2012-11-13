class Manage::ProjectMemberClaimsController < Manage::ApplicationController
  inherit_resources

  actions :all

  protected

  def begin_of_association_chain
    current_user
  end
end

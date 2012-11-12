class Manage::ClaimsController < Manage::ApplicationController
  inherit_resources

  actions :new, :create, :show

  protected

  def begin_of_association_chain
    current_user
  end
end

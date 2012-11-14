class Manage::ExpertClaimsController < Manage::ApplicationController
  inherit_resources

  actions :all

  has_scope :with_state, only: :index, default: 'pending'

  protected

  def begin_of_association_chain
    current_user
  end
end

class Manage::ClaimsController < Manage::ApplicationController
  load_and_authorize_resource
  actions :index, :update, :destroy

  has_scope :with_pending_state, :default => 1
  has_scope :only_expert_claims, :default => 1 do |controller, scope|
    scope.where(:type => 'ExpertClaim')
  end

  def update
    update! { manage_conference_claims_path(@current_conference)}
  end

  private

  def begin_of_association_chain
    @current_conference
  end

  def claim_params
    params.require(:claim).permit(:state_event)
  end
end

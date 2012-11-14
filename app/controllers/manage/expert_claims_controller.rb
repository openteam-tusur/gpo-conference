class Manage::ExpertClaimsController < Manage::ApplicationController
  inherit_resources

  actions :all

  has_scope :with_state, only: :index, default: 'pending'

  def update
    update! { collection_path }
  end

  def destroy
    destroy! { with_state_manage_expert_claims_path(:approved) }
  end

  protected

  def begin_of_association_chain
    current_user
  end
end

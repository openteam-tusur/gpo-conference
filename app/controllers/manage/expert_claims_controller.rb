class Manage::ExpertClaimsController < Manage::ApplicationController
  load_and_authorize_resource

  actions :index, :update, :destroy

  has_scope :with_approved_state, :default => 1

  private

  def begin_of_association_chain
    @current_conference
  end
end

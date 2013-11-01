class Manage::ClaimsController < Manage::ApplicationController
  belongs_to :conference, :finder => :find_by_year!

  actions :index, :update, :destroy

  has_scope :with_pending_state, :default => 1
  has_scope :only_expert_claims, :default => 1 do |controller, scope|
    scope.where(:type => 'ExpertClaim')
  end
end

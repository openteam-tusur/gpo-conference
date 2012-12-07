class Manage::ExpertClaimsController < Manage::ApplicationController
  belongs_to :conference, :finder => :find_by_year!

  actions :index, :update, :destroy

  has_scope :with_approved_state, :default => 1
end

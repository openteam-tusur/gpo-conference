class Manage::ExpertClaimsController < Manage::ApplicationController
  actions :all

  belongs_to :conference, :finder => :find_by_year!

  has_scope :with_state, only: :index, default: 'pending'

  def update
    update! { collection_path }
  end

  def destroy
    destroy! { with_state_manage_conference_expert_claims_path(@conference, :approved) }
  end

  protected
    alias_method :old_build_resource, :build_resource

    def build_resource
      old_build_resource.tap do |object|
        object.user = current_user
      end
    end
end

class Manage::ProjectMemberClaimsController < Manage::ApplicationController
  inherit_resources

  actions :new, :create, :show

  belongs_to :conference, :finder => :find_by_year!

  protected
    alias_method :old_build_resource, :build_resource

    def build_resource
      old_build_resource.tap do |object|
        object.user = current_user
      end
    end
end

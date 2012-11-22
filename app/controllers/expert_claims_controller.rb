class ExpertClaimsController < ApplicationController
  before_filter :authenticate_user!

  inherit_resources

  actions :new, :create

  belongs_to :conference, :finder => :find_by_year!

  def create
    create! do |success, failure|
      success.html { redirect_to dashboard_path and return }
      failure.html { render :create }
    end
  end

  protected
    alias_method :old_build_resource, :build_resource

    def build_resource
      old_build_resource.tap do |object|
        object.user = current_user
      end
    end
end

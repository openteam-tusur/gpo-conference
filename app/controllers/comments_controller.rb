class CommentsController < ApplicationController
  sso_authenticate_and_authorize

  inherit_resources

  actions :show, :new, :create

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme do
      belongs_to :project do
        belongs_to :discourse
      end
    end
  end

  layout false

  private
    alias_method :old_build_resource, :build_resource

    def build_resource
      old_build_resource.tap do |object|
        object.user = current_user
      end
    end
end

class CommentsController < ApplicationController
  before_filter :authenticate_user!

  before_filter :authorize_action!, :except => :show

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
    def comment_params
      params.require(:comment).permit(:parent_id, :body)
    end

    def authorize_action!
      can? :create, build_resource
    end

    alias_method :old_build_resource, :build_resource

    def build_resource
      old_build_resource.tap do |object|
        object.user_id = current_user.id
      end
    end
end

class CommentsController < ApplicationController
  inherit_resources

  belongs_to :theme do
    belongs_to :project do
      belongs_to :discourse
    end
  end

  actions :show, :new, :create
  after_filter :set_author, :only => :create

  layout false

  private
    def set_author
      resource.update_attribute :user_id, current_user.id
    end
end

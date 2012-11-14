class Manage::DiscourseController < Manage::ApplicationController
  inherit_resources

  belongs_to :project
end

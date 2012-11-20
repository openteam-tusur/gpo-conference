class ProjectsController < ApplicationController
  inherit_resources

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme
  end
end

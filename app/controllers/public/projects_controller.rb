class Public::ProjectsController < ApplicationController
  inherit_resources

  belongs_to :theme
end

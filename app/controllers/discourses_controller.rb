class DiscoursesController < ApplicationController
  inherit_resources

  belongs_to :theme do
    belongs_to :project
  end
end

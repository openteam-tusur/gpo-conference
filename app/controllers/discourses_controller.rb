class DiscoursesController < ApplicationController
  inherit_resources

  actions :show

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme do
      belongs_to :project
    end
  end
end


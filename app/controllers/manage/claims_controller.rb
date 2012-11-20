class Manage::ClaimsController < Manage::ApplicationController
  inherit_resources

  belongs_to :conference, :finder => :find_by_year!

  actions :new
end

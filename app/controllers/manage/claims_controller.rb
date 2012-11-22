class Manage::ClaimsController < Manage::ApplicationController
  belongs_to :conference, :finder => :find_by_year!

  actions :index, :edit, :update, :destroy
end

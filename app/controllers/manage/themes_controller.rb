class Manage::ThemesController < Manage::ApplicationController
  actions :index
  belongs_to :conference, :finder => :find_by_year!
end

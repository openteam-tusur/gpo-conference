class Manage::ConferencesController < Manage::ApplicationController
  actions :all, :except => [:show]
  load_and_authorize_resource
end

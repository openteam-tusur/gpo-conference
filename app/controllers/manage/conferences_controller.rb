class Manage::ConferencesController < Manage::ApplicationController
  actions :all, :except => [:show]
end

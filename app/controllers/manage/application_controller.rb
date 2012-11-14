class Manage::ApplicationController < ApplicationController
  esp_load_and_authorize_resource

  def index
    @projects = current_user.projects
  end
end

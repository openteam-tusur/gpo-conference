class Manage::ApplicationController < ApplicationController
  esp_load_and_authorize_resource

  # TODO: брать проекты только у текущего пользователя
  def index
    @projects = Project.last(5)
  end
end

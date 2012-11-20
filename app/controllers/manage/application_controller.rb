class Manage::ApplicationController < ApplicationController
  esp_load_and_authorize_resource

  before_filter :set_current_year
  before_filter :find_conference

  def index
    @projects = current_user.projects
  end

  private

    def set_current_year
      params.merge!(:conference_id => Time.zone.now.year.to_s) unless params.has_key?(:conference_id)
    end

    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

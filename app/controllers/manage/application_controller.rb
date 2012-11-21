class Manage::ApplicationController < ApplicationController
  sso_load_and_authorize_resource
  inherit_resources

  before_filter :set_current_year
  before_filter :find_conference

  def index
    @projects = current_user.projects
  end

  private
    def set_current_year
      params.merge!(:conference_id => Conference.current.year) unless params.has_key?(:conference_id)
    end

    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

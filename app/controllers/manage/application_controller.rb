class Manage::ApplicationController < ApplicationController
  sso_authenticate_and_authorize
  inherit_resources

  before_filter :set_current_year
  before_filter :find_conference

  private
    def set_current_year
      params.merge!(:conference_id => Conference.current.year) unless params.has_key?(:conference_id)
    end

    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

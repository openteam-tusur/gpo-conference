class StatisticsController < ApplicationController
  before_filter :find_conference

  def show
    @chairs_with_projects = @conference.projects.group_by(&:chair_abbr).sort
  end

  private
    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

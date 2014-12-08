class Manage::StatisticsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :find_conference

  def show
  end

  private
    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

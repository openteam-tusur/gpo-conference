class Manage::StatisticsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_conference

  def show
  end

  private
    def find_conference
      @conference = Conference.find_by_year!(params[:conference_id])
    end
end

class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_current_year

  def show
  end

  private
    def find_current_year
      @conference = Conference.current
    end

    def projects_for_rating
      current_user.projects_for_rating.for_current_conference
    end
end

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery :with => :exception
  before_action :find_current_conference

  private

  def find_current_conference
    @current_conference ||= params[:conference_id] ? Conference.find(params[:conference_id]) : Conference.current
  end
end

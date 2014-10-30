class ApplicationController < ActionController::Base
  include CacheBuster

  protect_from_forgery :with => :exception
  before_action :find_current_conference

  rescue_from CanCan::AccessDenied do |exception|
    flash['alert'] = 'Доступ запрещен!'
    redirect_to root_path
  end

  private

  def find_current_conference
    @current_conference ||= params[:conference_id] ? Conference.find_by!(:year => params[:conference_id]) : Conference.current
  end

  def authenticate_user!
    return if current_user
    flash['alert'] = 'Для доступа, необходимо войти в систему!'
    redirect_to root_path
  end
end

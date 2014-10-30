class ThemesController < ApplicationController
  def index
    @themes = @current_conference.themes
  end

  def show
    @theme = @current_conference.themes.find(params[:id])
  end
end

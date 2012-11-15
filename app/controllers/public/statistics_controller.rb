class Public::StatisticsController < ApplicationController
  def index
    @chairs = Chair.all
  end
end

class ThemesController < ApplicationController
  inherit_resources

  actions :index, :show

  belongs_to :conference, :finder => :find_by_year!

  before_filter :set_current_year

  private
    def set_current_year
      params.merge!(:conference_id => Conference.current.year) unless params.has_key?(:conference_id)
    end
end


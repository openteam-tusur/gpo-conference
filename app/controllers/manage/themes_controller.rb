class Manage::ThemesController < Manage::ApplicationController
  load_and_authorize_resource
  actions :index

  private

  def begin_of_association_chain
    @current_conference
  end
end

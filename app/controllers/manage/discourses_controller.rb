class Manage::DiscoursesController < Manage::ApplicationController
  inherit_resources

  layout false

  belongs_to :project

  def destroy
    destroy! { render :nothing => true, :layout => false and return }
  end
end

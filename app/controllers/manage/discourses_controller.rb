class Manage::DiscoursesController < Manage::ApplicationController
  inherit_resources

  layout false

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :project
  end

  def destroy
    destroy! { render :nothing => true, :layout => false and return }
  end
end

class DiscoursesController < ApplicationController
  inherit_resources

  before_filter :authenticate_user!, :except => :show

  load_and_authorize_resource
  skip_authorize_resource :only => :show

  actions :show, :new, :create, :update, :edit, :destroy

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme do
      belongs_to :project
    end
  end

  helper_method :rate

  def create
    create! do |success, failure|
      success.html { redirect_to dashboard_path and return }
      failure.html { render :new }
    end
  end

  def update
    update! do |success, failure|
      success.html { redirect_to dashboard_path and return }
      failure.html { render :edit }
    end
  end

  def destroy
    destroy! { redirect_to dashboard_path and return }
  end

  private

  def discourse_params
    params.require(:discourse).permit(:description, :title, :file, :authors => [])
  end

  def rate
    @rate ||= @discourse.rate_for(current_user)
  end
end


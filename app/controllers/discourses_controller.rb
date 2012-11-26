class DiscoursesController < ApplicationController
  inherit_resources

  load_and_authorize_resource
  skip_authorize_resource :only => :show

  before_filter :authenticate_user!, :except => :show

  actions :show, :new, :create, :update, :edit, :destroy

  layout false, :except => :show

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme do
      belongs_to :project
    end
  end

  helper_method :rate

  def create
    create! do |success, failure|
      success.html { render resource and return }
      failure.html { render :new }
    end
  end

  def update
    update! do |success, failure|
      success.html { render resource and return }
      failure.html { render :edit }
    end
  end

  def destroy
    destroy! { render :nothing => true and return }
  end

  private

  def rate
    @rate ||= resource.rate_for(current_user)
  end
end


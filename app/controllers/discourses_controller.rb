class DiscoursesController < ApplicationController
  sso_load_and_authorize_resource

  actions :show, :new, :create, :update, :edit, :destroy

  layout false, :except => :show

  belongs_to :conference, :finder => :find_by_year! do
    belongs_to :theme do
      belongs_to :project
    end
  end

  helper_method :rate

  def create
    create! { render resource and return }
  end

  def update
    update! { render resource and return }
  end

  def destroy
    destroy! { render :nothing => true and return }
  end

  private

  def rate
    @rate ||= resource.rate_for(current_user)
  end
end


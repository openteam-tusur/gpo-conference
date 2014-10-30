class RatesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_action!

  layout false

  inherit_resources

  belongs_to :discourse

  actions :edit, :update

  helper_method :rate

  def update
    update!{ render :edit and return }
  end

  private

  def rate_params
    params.require(:rate).permit(:urgency, :practicality, :novelty, :typography)
  end

  def resource
    @rate ||= parent.rate_for(current_user)
  end

  alias_method :rate, :resource

  def authorize_action!
    authorize! :update, resource
  end
end

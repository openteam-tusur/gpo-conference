class RatesController < ApplicationController
  before_filter :authenticate_user!

  layout false

  inherit_resources

  belongs_to :discourse

  actions :edit, :update

  has_scope :rated_by_me, default: true, type: :boolean do |controller, scope|
    scope.rated_by(controller.current_user)
  end

  helper_method :rate

  private

  def resource
    @rate ||= collection.first || collection.build
  end

  alias_method :rate, :resource
end

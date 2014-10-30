class Manage::ApplicationController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources
end

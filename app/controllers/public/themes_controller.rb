class Public::ThemesController < ApplicationController
  inherit_resources
  actions :only => [:index, :show]
end

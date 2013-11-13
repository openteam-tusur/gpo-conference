require 'openteam/capistrano/recipes'
require 'whenever/capistrano'

set :shared_children, fetch(:shared_children) + %w[public/help]
set :default_stage, :tusur

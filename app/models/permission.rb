class Permission < ActiveRecord::Base
  include AuthClient::Permission
  acts_as_auth_client_permission :roles => %w[administrator expert participant manager]
end

class Discourse < ActiveRecord::Base
  belongs_to :project
  attr_accessible :description, :url, :vfs_path
end

class Chair < ActiveRecord::Base
  attr_accessible :abbr, :chief, :faculty, :title

  validates_presence_of :abbr, :chief, :title
end

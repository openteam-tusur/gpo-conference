class Chair < ActiveRecord::Base
  attr_accessible :abbr, :chief, :faculty, :title, :gpo_id

  validates_presence_of :abbr, :chief, :title, :gpo_id
end

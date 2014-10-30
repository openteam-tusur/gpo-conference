class Chair < ActiveRecord::Base
  validates_presence_of :abbr, :chief, :title, :gpo_id

  has_many :projects
  has_many :discourses, :through => :projects
  has_many :users, :through => :projects
end

class Theme < ActiveRecord::Base
  attr_accessible :name, :gpo_id

  has_many :projects

  validates_presence_of :name, :gpo_id
end

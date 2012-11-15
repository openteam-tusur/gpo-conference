class Comment < ActiveRecord::Base
  attr_accessible :body, :ancestry

  has_ancestry

  belongs_to :user
  belongs_to :discourse

  normalize_attribute :body, :ancestry
  validates_presence_of :body

  delegate :name, :to => :user, :prefix => true
end

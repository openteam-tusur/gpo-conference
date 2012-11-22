# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  discourse_id :integer
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ancestry     :string(255)
#

class Comment < ActiveRecord::Base
  attr_accessible :body, :ancestry, :parent_id

  has_ancestry

  belongs_to :user
  belongs_to :discourse

  normalize_attribute :body, :ancestry
  validates_presence_of :body

  delegate :name, :to => :user, :prefix => true
end

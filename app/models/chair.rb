# == Schema Information
#
# Table name: chairs
#
#  id         :integer          not null, primary key
#  abbr       :string(255)
#  chief      :string(255)
#  faculty    :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gpo_id     :integer
#

class Chair < ActiveRecord::Base
  attr_accessible :abbr, :chief, :faculty, :title, :gpo_id

  validates_presence_of :abbr, :chief, :title, :gpo_id

  has_many :projects
  has_many :discourses, :through => :projects
  has_many :users, :through => :projects
end

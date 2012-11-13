# == Schema Information
#
# Table name: themes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gpo_id     :integer
#

class Theme < ActiveRecord::Base
  attr_accessible :name, :gpo_id

  has_many :projects

  validates_presence_of :name, :gpo_id

  scope :ordered_by_name, :order => :name
end

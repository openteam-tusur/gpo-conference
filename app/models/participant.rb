# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  project_id :integer
#  course     :integer
#  edu_group  :string(255)
#  email      :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  mid_name   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ActiveRecord::Base
  attr_accessible :edu_group, :email, :first_name, :last_name, :mid_name, :course, :project_id

  belongs_to :project

  validates_presence_of :project
end

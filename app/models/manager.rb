# == Schema Information
#
# Table name: managers
#
#  id         :integer          not null, primary key
#  project_id :integer
#  email      :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  mid_name   :string(255)
#  gpo_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Manager < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :mid_name, :project_id, :gpo_id

  belongs_to :project

  validates_presence_of :project
end

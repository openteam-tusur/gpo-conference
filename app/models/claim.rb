# == Schema Information
#
# Table name: claims
#
#  id         :integer          not null, primary key
#  chair_id   :integer
#  project_id :integer
#  user_id    :integer
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Claim < ActiveRecord::Base
  attr_accessible :role, :chair_id

  belongs_to :chair
  belongs_to :project
  belongs_to :user
end

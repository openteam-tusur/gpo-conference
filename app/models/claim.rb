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
  extend Enumerize

  attr_accessible :role, :project_id

  belongs_to :chair
  belongs_to :project
  belongs_to :user

  validates_presence_of :role, :project

  after_create :approve, if: :project_has_user?

  enumerize :role, in: [:participant, :project_manager]

  state_machine :state, initial: :pending do
    event :approve do
      transition pending: :approved
    end
  end

  private

  def project_has_user?
    role == 'project_manager' ? project.has_project_manager?(user) : project.has_participant?(user)
  end
end

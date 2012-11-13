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

  enumerize :role,
    in: [:project_participant, :project_manager],
    predicates: { prefix: true }

  state_machine :state, initial: :pending do
    event :approve do
      transition pending: :approved
    end

    after_transition pending: :approved, do: :create_permissions
  end

  private

  def project_has_user?
    return project.has_participant?(user) if role_project_participant?
    return project.has_manager?(user)     if role_project_manager?

    false
  end

  def create_permissions
    user.permissions.create(context: Context.root, role: :participant)
    user.permissions.create(context: project, role: :project_participant) if role_project_participant?
  end
end

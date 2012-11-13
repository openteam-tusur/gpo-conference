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
#  state      :string(255)
#  type       :string(255)
#

class Claim < ActiveRecord::Base
  extend Enumerize

  attr_accessible :role, :project_id, :project_name

  attr_accessor :project_name

  belongs_to :chair
  belongs_to :project
  belongs_to :user

  validates_presence_of :role, :project_id

  validate :user_membership_of_project, :if => :project_id?

  after_create :approve, if: ->(claim) { claim.role_project_participant? || claim.role_project_manager? }

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

  def user_membership_of_project
    if !project.has_participant?(user) && !project.has_manager?(user)
      errors[:base] << I18n.t('activerecord.errors.claim.creating_error')
    end
  end

  def create_permissions
    user.permissions.create(context: Context.root, role: :participant)
    user.permissions.create(context: project, role: :project_participant) if role_project_participant?
  end
end

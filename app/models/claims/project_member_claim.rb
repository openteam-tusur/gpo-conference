# == Schema Information
#
# Table name: claims
#
#  id         :integer          not null, primary key
#  project_id :integer
#  user_id    :integer
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(255)
#  type       :string(255)
#  theme_id   :integer
#

class ProjectMemberClaim < Claim
  extend Enumerize

  attr_accessible :role, :project_id, :project_name

  attr_accessor :project_name

  belongs_to :project

  validate :user_membership_of_project, :if => :project_id?

  validates_presence_of :role, :project_id

  after_create :create_permissions

  enumerize :role,
    in: [:project_participant, :project_manager],
    predicates: { prefix: true }

  private

  def user_membership_of_project
    if !project.has_participant?(user) && !project.has_manager?(user)
      errors[:base] << I18n.t('activerecord.errors.claim.creating_error')
    end
  end

  def create_permissions
    user.permissions.create(role: :participant)

    if role_project_participant? && project.has_participant?(user)
      user.permissions.create(context: project, role: :project_participant)
    end

    if role_project_manager? && project.has_participant?(user)
      user.permissions.create(context: project, role: :project_manager)
    end
    true
  end
end

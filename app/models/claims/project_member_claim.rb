# == Schema Information
#
# Table name: claims
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  user_id       :integer
#  role          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string(255)
#  type          :string(255)
#  theme_id      :integer
#  conference_id :integer
#

class ProjectMemberClaim < Claim
  extend Enumerize

  attr_accessible :role, :project_id, :project_name

  belongs_to :project

  validates_presence_of :role, :project

  validates_uniqueness_of :role, scope: [:user_id, :project_id]

  validate :user_membership_of_project

  after_create :create_permissions

  attr_accessor :project_name

  enumerize :role,
    in: [:participant, :manager],
    predicates: { prefix: true }

  private

  def user_membership_of_project
    errors[:base] << I18n.t('activerecord.errors.claim.creating_error') unless project.role_for(user)
  end

  def create_permissions
    user.permissions.create!(context: project, role: project.role_for(user))
  end
end

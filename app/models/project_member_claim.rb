class ProjectMemberClaim < Claim
  extend Enumerize

  belongs_to :project

  validates_presence_of :project_id

  validates_uniqueness_of :project_id, :scope => [:user_id]

  validate :user_membership_of_project, :if => :project

  before_validation :set_role

  after_create :create_permission
  after_destroy :destroy_permission

  enumerize :role, :in => [:participant, :manager]

  attr_accessor :project_name

  private

  def user_membership_of_project
    errors[:base] << I18n.t('activerecord.errors.claim.creating_error') unless role
  end

  def create_permission
    user.permissions.create!(context: project, role: role)
  end

  def destroy_permission
    user.permissions.for_context(project).destroy_all
  end

  def set_role
    self.role = project.try :role_for, user
  end

  def user
    @user ||= User.find_by(:id => user_id)
  end
end

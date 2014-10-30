class ExpertClaim < Claim
  extend Enumerize

  belongs_to :theme

  validates_presence_of :theme_id

  validates_uniqueness_of :theme_id, :scope => [:user_id]

  default_value_for :role, :expert

  after_destroy :destroy_permission

  delegate :surname, :to => :user, :prefix => true

  state_machine :state, initial: :pending do
    event :approve do
      transition pending: :approved
    end

    after_transition pending: :approved, do: :create_permission
  end

  enumerize :role,
    in: [:expert],
    predicates: { prefix: true }

  private

  def create_permission
    user.permissions.create!(context: theme, role: :expert)
  end

  def destroy_permission
    user.permissions.for_context(theme).for_role(role).destroy_all
  end
end

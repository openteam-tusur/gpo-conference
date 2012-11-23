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

class ExpertClaim < Claim
  extend Enumerize

  attr_accessible :theme_id, :state_event

  belongs_to :theme

  validates_presence_of :theme_id

  default_value_for :role, :expert

  after_destroy :destroy_permission

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

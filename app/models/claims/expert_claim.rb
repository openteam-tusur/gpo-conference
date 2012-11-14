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

class ExpertClaim < Claim
  attr_accessible :theme_id, :state_event

  belongs_to :theme

  validates_presence_of :theme_id

  scope :with_state, ->(state) { where state: state }

  after_destroy :destroy_permissions

  state_machine :state, initial: :pending do
    event :approve do
      transition pending: :approved
    end

    after_transition pending: :approved, do: :create_permissions
  end

  private

  def create_permissions
    user.create_participant_permission unless user.participant_permission
    user.permissions.create(context: theme, role: :expert)
  end

  def destroy_permissions
    user.permissions.where(context_type: 'Theme', context_id: theme.id, role: :expert).first.destroy
    user.participant_permission_destroy if user.theme_expert_permissions.empty?
  end
end

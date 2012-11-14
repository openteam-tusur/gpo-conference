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

  state_machine :state, initial: :pending do
    event :approve do
      transition pending: :approved
    end

    after_transition pending: :approved, do: :create_permissions
  end

  private

  def create_permissions
    user.permissions.create(context: Context.root, role: :participant)
    user.permissions.create(context: theme, role: :expert)
  end
end

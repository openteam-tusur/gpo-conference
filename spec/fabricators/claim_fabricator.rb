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

Fabricator(:project_member_claim) do
  project
  user
  role :participant
end

Fabricator(:expert_claim) do
  theme
  user
end

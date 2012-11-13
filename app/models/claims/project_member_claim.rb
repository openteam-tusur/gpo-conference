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

class ProjectMemberClaim < Claim

end

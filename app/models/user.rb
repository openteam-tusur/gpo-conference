# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  name               :text
#  email              :text
#  nickname           :text
#  first_name         :text
#  last_name          :text
#  location           :text
#  description        :text
#  image              :text
#  phone              :text
#  urls               :text
#  raw_info           :text
#  sign_in_count      :integer
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ActiveRecord::Base
  esp_auth_user

  has_many :expert_claims
  has_many :project_member_claims

  has_many :permissions
  has_many :projects, through: :permissions, source: :context, source_type: 'Project'
  has_many :themes,   through: :permissions, source: :context, source_type: 'Theme'
  has_many :conferences, :through => :projects

  has_many :theme_expert_permissions, class_name: 'Permission',
    conditions: { context_type: 'Theme', role: :expert }

  has_one :participant_permission, class_name: 'Permission',
    conditions: { context_type: 'Context', context_id: Context.root.id, role: :participant }

  delegate :destroy, to: :participant_permission, prefix: true, allow_nil: true
end

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
end

# == Schema Information
#
# Table name: chairs
#
#  id         :integer          not null, primary key
#  abbr       :string(255)
#  chief      :string(255)
#  faculty    :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  gpo_id     :integer
#

Fabricator(:chair) do
  abbr    'abbr'
  chief   'chief'
  faculty 'faculty'
  title   'title'
  gpo_id  1
end

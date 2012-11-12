# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  gpo_id     :integer
#  theme_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  chair_id   :integer
#

Fabricator(:project) do
  chair
  theme
  title 'title'
  gpo_id 1
end

# == Schema Information
#
# Table name: themes
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  gpo_id        :integer
#  conference_id :integer
#

Fabricator(:theme) do
  conference
  gpo_id  1
  name    'name'
end

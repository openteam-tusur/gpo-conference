# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  project_id :integer
#  course     :integer
#  edu_group  :string(255)
#  email      :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  mid_name   :string(255)
#  gpo_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:participant) do
  project    nil
  edu_group  "MyString"
  email      "MyString"
  first_name "MyString"
  last_name  "MyString"
  mid_name   "MyString"
end

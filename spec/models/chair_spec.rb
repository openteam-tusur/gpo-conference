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

require 'spec_helper'

describe Chair do
  pending "add some examples to (or delete) #{__FILE__}"
end

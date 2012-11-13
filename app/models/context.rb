# == Schema Information
#
# Table name: contexts
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  ancestry   :string(255)
#  weight     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Context < ActiveRecord::Base
  esp_auth_context

  def self.root
    find_or_create_by_title('Root context')
  end
end

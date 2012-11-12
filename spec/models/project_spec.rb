# encoding: utf-8

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

require 'spec_helper'

describe Project do
  let(:user) { Fabricate :user, last_name: 'Иванов', first_name: 'Иван' }
  let(:project) { Fabricate :project }
  let(:members) { [ Hashie::Mash.new(last_name: 'Иванов', first_name: 'Иван', mid_name: 'Иванович') ] }

  describe '#has_participant?' do
    before { project.stub(:participants).and_return(members) }

    specify { project.has_participant?(user).should be_true }
  end

  describe '#has_project_manager?' do
    before { project.stub(:project_managers).and_return(members) }

    specify { project.has_project_manager?(user).should be_true }
  end
end

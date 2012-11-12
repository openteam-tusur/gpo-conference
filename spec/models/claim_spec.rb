# encoding: utf-8
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
#

require 'spec_helper'

describe Claim do
  describe 'try approve after create' do
    let(:user) { Fabricate :user, last_name: 'Иванов', first_name: 'Иван' }
    let(:project) { Fabricate :project }
    let(:members) { [ Hashie::Mash.new(last_name: 'Иванов', first_name: 'Иван', mid_name: 'Иванович') ] }

    context 'participant' do
      subject { Fabricate :claim, user: user, project: project, role: :participant }

      before { project.stub(:participants).and_return(members) }

      it { should be_approved }
    end

    context 'project_manager' do
      subject { Fabricate :claim, user: user, project: project, role: :project_manager }

      before { project.stub(:project_managers).and_return(members) }

      it { should be_approved }
    end
  end
end
# encoding: utf-8
# == Schema Information
#
# Table name: claims
#
#  id            :integer          not null, primary key
#  project_id    :integer
#  user_id       :integer
#  role          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  state         :string(255)
#  type          :string(255)
#  theme_id      :integer
#  conference_id :integer
#

require 'spec_helper'

describe ProjectMemberClaim do
  describe 'try approve after create' do
    let(:user)          { Fabricate :user, last_name: 'Иванов', first_name: 'Иван' }
    let(:project)       { Fabricate :project }
    let(:participants)  { [ Hashie::Mash.new(user.attributes) ] }
    let(:managers)      { [ Hashie::Mash.new(user.attributes) ] }

    before { project.stub(:participants).and_return(participants) }
    before { project.stub(:managers).and_return(managers) }

    def create_claim
      Fabricate :project_member_claim, user: user, project: project, role: :participant
    end

    context 'non member' do
      let(:managers) { [] }
      let(:participants) { [] }

      specify { expect { create_claim }.to raise_error(ActiveRecord::RecordInvalid) }
    end

    context 'member' do
      before { create_claim }

      context 'participant' do
        let(:managers) { [] }

        specify { user.should be_participant_of(project) }
      end

      context 'manager' do
        let(:participants) { [] }

        specify { user.should be_manager_of(project) }
      end
    end
  end
end

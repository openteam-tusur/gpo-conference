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
    let(:participants)  { [ Hashie::Mash.new(last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович') ] }
    let(:managers)      { [ Hashie::Mash.new(last_name: 'Петров', first_name: 'Петр', middle_name: 'Петрович') ] }

    let(:participant_permission) { subject.user.permissions.for_context(nil).for_role(:participant).first }
    let(:project_participant_permission) { subject.user.permissions.for_context(project).for_role(:project_participant).first }

    context 'non member' do
      let(:claim) { Fabricate :project_member_claim, user: user, project: project, role: :project_participant }

      before { project.stub(:participants).and_return([]) }
      before { project.stub(:project_managers).and_return([]) }

      specify {
        expect { Fabricate(:project_member_claim, user: user, project: project, role: :project_participant) }.to raise_error(ActiveRecord::RecordInvalid)
      }
    end

    describe 'member' do
      before { project.stub(:participants).and_return(participants) }
      before { project.stub(:project_managers).and_return(managers) }

      context 'participant' do
        subject { Fabricate :project_member_claim, user: user, project: project, role: :project_participant }

        specify { participant_permission.should be_persisted }
        specify { project_participant_permission.should be_persisted }
      end

      context 'project_manager' do
        subject { Fabricate :project_member_claim, user: user, project: project, role: :project_manager }

        specify { participant_permission.should be_persisted }
      end
    end
  end
end

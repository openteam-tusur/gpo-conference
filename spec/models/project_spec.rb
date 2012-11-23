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
#  cipher     :string(255)
#

require 'spec_helper'

describe Project do
  let(:user) { Fabricate :user, last_name: 'Иванов', first_name: 'Иван' }
  let(:project) { Fabricate :project }
  let(:members) { [ Hashie::Mash.new(last_name: 'Иванов', first_name: 'Иван', middle_name: 'Иванович') ] }

  describe '#role_for(user)' do
    before { project.stub(:managers).and_return([]) }
    before { project.stub(:participants).and_return([]) }

    subject { project.role_for(user) }

    it { should be_nil }

    context 'participant' do
      before { project.stub(:participants).and_return(members) }
      it { should == :participant }
    end

    context 'manager' do
      before { project.stub(:managers).and_return(members) }
      it { should == :manager }
    end
  end

end

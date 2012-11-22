require 'spec_helper'

describe Rate do
  it { should belong_to :discourse }
  it { should belong_to :user }
  it { should validate_presence_of :urgency }
  it { should validate_presence_of :practicality }
  it { should validate_presence_of :novelty }
  it { should validate_presence_of :typography }
  describe '#total' do
    let(:rate) { Rate.new }

    subject { rate.total }

    it { should == 0.0 }

    context 'with marks 10, 10, 10, 10' do
      let(:rate) { Rate.new(urgency: 10, practicality: 10, novelty: 10, typography: 10) }
      it { should == 10.0 }
    end

    context 'with marks 10, 0, 0, 0' do
      let(:rate) { Rate.new(urgency: 10) }
      it { should == 3.0 }
    end
    context 'with marks 0, 10, 0, 0' do
      let(:rate) { Rate.new(practicality: 10) }
      it { should == 3.0 }
    end
    context 'with marks 0, 0, 10, 0' do
      let(:rate) { Rate.new(novelty: 10) }
      it { should == 3.0 }
    end
    context 'with marks 0, 0, 0, 10' do
      let(:rate) { Rate.new(typography: 10) }
      it { should == 1.0 }
    end

    context 'with cached mark' do
      let(:rate) { Rate.new{|rate| rate.cached_total = 10.0 } }
      it { should == 10.0 }
    end
  end

  describe '#cached_total' do
    context 'after_save' do
      subject { Rate.new(urgency: 10, practicality: 10, novelty: 10, typography: 10) }
      before { subject.save }
      its(:cached_total) { should == 10.0 }
    end
  end
end

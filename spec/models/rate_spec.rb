require 'spec_helper'

describe Rate do
  it { should belong_to :discourse }
  it { should belong_to :user }

  it { should validate_presence_of :urgency }
  it { should validate_presence_of :practicality }
  it { should validate_presence_of :novelty }
  it { should validate_presence_of :typography }

  it { should validate_numericality_of(:urgency).only_integer }
  it { should validate_numericality_of(:practicality).only_integer }
  it { should validate_numericality_of(:novelty).only_integer }
  it { should validate_numericality_of(:typography).only_integer }

  it { should ensure_inclusion_of(:urgency).in_range(1..10) }
  it { should ensure_inclusion_of(:practicality).in_range(1..10) }
  it { should ensure_inclusion_of(:novelty).in_range(1..10) }
  it { should ensure_inclusion_of(:typography).in_range(1..10) }

  describe '#total' do
    let(:rate) { Fabricate.build(:rate) }

    subject { rate.total }

    it { should be_within(0.001).of(1.0) }

    context 'with marks 10, 10, 10, 10' do
      let(:rate) { Fabricate.build(:rate, urgency: 10, practicality: 10, novelty: 10, typography: 10) }
      it { should == 10.0 }
    end

    context 'with marks 10, 1, 1, 1' do
      let(:rate) { Fabricate.build(:rate, urgency: 10) }
      it { should be_within(0.001).of(3.7) }
    end
    context 'with marks 1, 10, 1, 1' do
      let(:rate) { Fabricate.build(:rate, practicality: 10) }
      it { should be_within(0.001).of(3.7) }
    end
    context 'with marks 1, 1, 10, 1' do
      let(:rate) { Fabricate.build(:rate, novelty: 10) }
      it { should be_within(0.001).of(3.7) }
    end
    context 'with marks 1, 1, 1, 10' do
      let(:rate) { Fabricate.build(:rate, typography: 10) }
      it { should be_within(0.001).of(1.9) }
    end

    context 'with cached mark' do
      let(:rate) { Fabricate.build(:rate, cached_total: 10) }
      it { should == 10.0 }
    end
  end

  describe '#cached_total' do
    context 'after_save' do
      subject { Fabricate.build(:rate, urgency: 10, practicality: 10, novelty: 10, typography: 10) }
      before { subject.save }
      its(:cached_total) { should == 10.0 }
    end
  end
end

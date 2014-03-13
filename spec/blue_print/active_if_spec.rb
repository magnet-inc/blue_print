require 'spec_helper'

describe BluePrint::ActiveIf do
  describe '.resolve' do
    let(:named_active_if) { described_class.new(:named) }

    subject(:resolve) { described_class.resolve(name) }

    context 'with named_active_if' do
      let(:name) { named_active_if }

      it { should eq(named_active_if) }
    end

    context 'with :named' do
      let(:name) { named_active_if.name }

      it { should eq(named_active_if) }
    end

    context 'with :unnamed' do
      let(:name) { :unnamed }

      it { should be_nil }
    end
  end

  describe '#active?' do
    it 'caches call' do
      BluePrint.env = BluePrint::Environment.new(self)

      calling = double
      calling.should_receive(:message).once.and_return(true)
      active_if = described_class.new do |env|
        calling.message
      end

      expect(active_if.active?).to be_true
      expect(active_if.active?).to be_true
    end
  end

  describe '#deactive?' do
    it 'be negative active' do
      BluePrint.env = BluePrint::Environment.new(self)

      active_if = described_class.new do |env|
        true
      end

      expect(active_if.deactive?).to be_false
    end
  end
end

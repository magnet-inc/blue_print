require 'spec_helper'

class SpecContext < BluePrint::Context
end

describe BluePrint::Context do
  subject(:context) { SpecContext }

  after do
    context.active_ifs.clear
  end

  describe '#resolve' do
    subject { BluePrint::Context.resolve(name) }

    context 'with :spec' do
      let(:name) { :spec }

      it { should eq(context) }
    end

    context 'with context' do
      let(:name) { context }

      it { should eq(context) }
    end
  end

  describe '#active_if' do
    let(:named_active_if) { BluePrint::ActiveIf.new(:named) }

    before do
      context.active_if named_active_if.name, :null_active_if do
        true
      end
    end

    subject(:active_ifs) { context.active_ifs }

    it { expect(active_ifs).to have_at_most(2).active_ifs }
  end

  describe '#context_name' do
    subject(:context_name) { context.context_name }

    it { should eq(:spec_context) }
  end

  describe '#active?' do
    let(:always_active) { double(active?: true) }
    let(:always_deactive) { double(active?: false) }

    subject { context.active? }

    context 'with always actives' do
      before do
        context.active_if(always_active, always_active)
      end

      it { expect(subject).to be_truthy }
    end

    context 'with always deactives' do
      before do
        context.active_if(always_deactive, always_deactive)
      end

      it { expect(subject).to be_falsy }
    end

    context 'with both' do
      before do
        context.active_if(always_active, always_deactive)
      end

      it { expect(subject).to be_falsy }
    end

    context 'only always active' do
      before do
        context.active_if(always_active)
      end

      it { expect(subject).to be_truthy }
    end

    context 'with empty' do
      it { expect(subject).to be_falsy }
    end
  end

  describe '#deactive?' do
    subject(:deactive) { context.deactive? }

    it 'be negative active' do
      allow(context).to receive(:active?).and_return(false)

      expect(deactive).to be_truthy
    end
  end

  describe '#activate!' do
    before do
      context.active_if { false }
      context.activate!
    end

    it { should be_active }
  end

  describe '#deactivate!' do
    before do
      context.active_if { true }
      context.deactivate!
    end

    it { should be_deactive }
  end

  describe '#cast' do
    let(:klass) { Class.new }
    let(:role) { Module.new }

    before do
      context.cast(klass, as: role)
      context.cast(klass, as: role)
    end

    it 'be set casting' do
      expect(context.casting[klass]).to have_at_most(1).role
      expect(context.casting[klass]).to include(role)
    end
  end

  describe '#action!' do
    let(:klass) { Class.new }
    let(:role) { Module.new }

    before do
      context.cast(klass, as: role)
    end

    it 'be act role' do
      expect(klass.ancestors.first).to eq(role)
    end
  end
end

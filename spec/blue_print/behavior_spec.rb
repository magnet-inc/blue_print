require 'spec_helper'

module TestContext
  def self.active?
    true
  end

  module TestBehavior
    extend BluePrint::Behavior

    module ClassMethods
      def valid?
        true
      end

      def invalid?
        false
      end

      def echo(word)
        "#{word} with behavior"
      end
    end

    def valid?
      true
    end

    def invalid?
      false
    end

    def echo(word)
      "#{word} with behavior"
    end
  end
end

describe BluePrint::Behavior do
  let(:target_class) do
    Class.new do
      prepend TestContext::TestBehavior

      def self.valid?
        false
      end

      def self.echo(word)
        word
      end

      def valid?
        false
      end

      def echo(word)
        word
      end
    end
  end
  let(:target) { target_class.new }

  shared_examples 'as behavior' do
    describe '#context_name' do
      subject { behavior.context_name }

      it { should eq(:test_context) }
    end

    describe '#behavior_name' do
      subject { behavior.behavior_name }

      it { should eq(:test_context__test_behavior) }
    end

    describe 'target' do
      subject { test_target }

      it { should respond_to(:valid_with_test_context__test_behavior?) }
      it { should be_valid }

      it { should_not be_invalid }

      specify { expect(test_target.echo('hi')).to eq('hi with behavior') }

      context 'when deactive context' do
        before { TestContext.stub(active?: false) }

        it { should_not be_valid }
        specify { expect { target.invalid }.to raise_error }
        specify { expect(test_target.echo('hi')).to eq('hi') }
      end
    end
  end

  describe 'InstanceMethod' do
    let(:test_target) { target }
    subject(:behavior) { TestContext::TestBehavior }

    it { should be_const_defined('ClassMethods') }

    include_examples 'as behavior'
  end

  describe 'ClassMethods' do
    let(:test_target) { target_class }
    subject(:behavior) { TestContext::TestBehavior::ClassMethods }

    it { should_not be_const_defined('ClassMethods') }

    include_examples 'as behavior'
  end
end

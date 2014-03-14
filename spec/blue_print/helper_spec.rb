require 'spec_helper'

describe BluePrint::Helper do
  subject(:helper) { Class.new { include BluePrint::Helper }.new }

  describe '#within_cotext_of' do
    context 'with active context' do
      let(:context) { double(active?: true) }

      it 'runs block' do
        helper.should_receive(:message).once
        helper.within_cotext_of(context) do |env|
          expect(env).to eq(BluePrint.env)
          helper.message
        end
      end
    end

    context 'with deactive context' do
      let(:context) { double(active?: false) }

      it 'runs block' do
        helper.should_not_receive(:message)
        helper.within_cotext_of(context) do
          helper.message
        end
      end

      it 'runs fallback' do
        helper.should_receive(:fallback)
        helper.should_not_receive(:message)
        helper.within_cotext_of(context, proc { helper.fallback }) do
          helper.message
        end
      end
    end
  end
end

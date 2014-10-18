require 'spec_helper'

describe BluePrint::Helper do
  subject(:helper) { Class.new { include BluePrint::Helper }.new }

  describe '#within_context_of' do
    context 'with active context' do
      let(:context) { double(active?: true) }

      it 'runs block' do
        expect(helper).to receive(:message).once
        helper.within_context_of(context) do |env|
          expect(env).to eq(BluePrint.env)
          helper.message
        end
      end
    end

    context 'with deactive context' do
      let(:context) { double(active?: false) }

      it 'not runs block' do
        expect(helper).to_not receive(:message)
        helper.within_context_of(context) do
          helper.message
        end
      end

      it 'runs fallback' do
        expect(helper).to receive(:fallback)
        expect(helper).to_not receive(:message)
        helper.within_context_of(context, proc { helper.fallback }) do
          helper.message
        end
      end
    end
  end

  describe '#without_context_of' do
    context 'with deactive context' do
      let(:context) { double(active?: false) }

      it 'runs block' do
        expect(helper).to receive(:message).once
        helper.without_context_of(context) do |env|
          expect(env).to eq(BluePrint.env)
          helper.message
        end
      end
    end

    context 'with active context' do
      let(:context) { double(active?: true) }

      it 'not runs block' do
        expect(helper).to_not receive(:message)
        helper.without_context_of(context) do
          helper.message
        end
      end

      it 'runs fallback' do
        expect(helper).to receive(:fallback)
        expect(helper).to_not receive(:message)
        helper.without_context_of(context, proc { helper.fallback }) do
          helper.message
        end
      end
    end
  end
end

require 'spec_helper'

describe BluePrint do
  let(:env) { double }

  describe '#env' do
    it 'be inherited by parent thread' do
      BluePrint.env = env

      expect(env).to receive(:message).twice

      BluePrint.env.message
      Thread.new { BluePrint.env.message }.join
    end
  end

  describe '#clear!' do
    it 'be clear only current thread' do
      BluePrint.env = env

      Thread.new do
        BluePrint.clear!
      end.join

      expect(BluePrint.env).to eq(env)

      BluePrint.clear!

      expect(BluePrint.env).to be_nil
    end
  end
end

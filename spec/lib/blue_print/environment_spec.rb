require 'spec_helper'

describe BluePrint::Environment do
  let(:context) { double(a: 1) }
  subject(:env) { described_class.new(context) }

  describe '#within' do
    it 'keeps scope' do
      b = 2
      env[:rspec] = self
      env.within do |env|
        env[:rspec].expect(a).to env[:rspec].eq(1)
        env[:rspec].expect(b).to env[:rspec].eq(2)
      end
    end
  end
end

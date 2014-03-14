require 'spec_helper'

describe <%= class_name %>Context do
  context 'in active' do
    before { described_class.stub(active?: true) }
  end

  context 'in deactive' do
    before { described_class.stub(active?: false) }
  end
end

require 'spec_helper'

describe <%= class_name %>Context do
  context 'in active' do
    before { described_class.activate! }
  end

  context 'in deactive' do
    before { described_class.deactivate! }
  end
end

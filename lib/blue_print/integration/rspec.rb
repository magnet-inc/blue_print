require 'active_support/concern'
require 'blue_print/integration'

module BluePrint::Integration::RSpec
  extend ActiveSupport::Concern

  included do
    before(:each) do
      BluePrint.env = BluePrint::Environment.new(self)
    end

    after(:each) do
      BluePrint.clear!
    end
  end
end

RSpec.configure do |config|
  config.include BluePrint::Integration::RSpec
end

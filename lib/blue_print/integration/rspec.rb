require 'active_support/concern'
require 'blue_print/integration'

module BluePrint::Integration::RSpec
  extend ActiveSupport::Concern

  included do
    after(:each) do
      BluePrint.clear!
    end
  end
end

RSpec.configure do |config|
  config.include BluePrint::Integration::RSpec
end

require 'grape/api'
require 'blue_print/integration/grape'
require 'blue_print/integration/grape/middleware'
require 'blue_print/integration/grape/helper'

class << Grape::API
  def inherited_with_blue_print(klass)
    inherited_without_blue_print(klass)
    klass.use BluePrint::Integration::Grape::Middleware
    klass.helpers BluePrint::Integration::Grape::Helper
  end
  alias_method_chain :inherited, :blue_print
end

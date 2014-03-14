require 'grape/middleware/base'
require 'blue_print/integration/grape'

class BluePrint::Integration::Grape::Middleware < ::Grape::Middleware::Base
  def before
    BluePrint.env = BluePrint::Environment.new(env['api.endpoint'])
  end

  def after
    BluePrint.clear!
  end
end

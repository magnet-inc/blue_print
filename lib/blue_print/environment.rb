require 'hashie'
require 'blue_print'

class BluePrint::Environment < Hashie::Mash
  def initialize(context, default = nil)
    super({}, default)
    @context = context
  end

  def within(&block)
    @context.instance_exec(self, &block)
  end
end

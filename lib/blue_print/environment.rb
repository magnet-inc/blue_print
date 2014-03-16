require 'blue_print'

class BluePrint::Environment < Hash
  def initialize(context, default = nil)
    super(default)
    @context = context
  end

  def within(&block)
    @context.instance_exec(self, &block)
  end
end

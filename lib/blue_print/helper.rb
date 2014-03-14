require 'blue_print'

module BluePrint::Helper
  def within_context_of(name_or_context, fallback = nil, &block)
    context = BluePrint::Context.resolve(name_or_context)

    if context.active?
      yield BluePrint.env
    else
      fallback.respond_to?(:call) && fallback.call
    end
  end
end

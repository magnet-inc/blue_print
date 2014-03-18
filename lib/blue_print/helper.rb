require 'blue_print'

module BluePrint::Helper
  def within_context_of(name_or_context, fallback = nil, &block)
    context = BluePrint::Context.resolve(name_or_context)

    if context.active?
      block_given? && yield(BluePrint.env)
    else
      fallback.respond_to?(:call) && fallback.call(BluePrint.env)
    end
  end

  def without_context_of(name_or_context, fallback = nil, &block)
    within_context_of(name_or_context, block, &fallback)
  end
end

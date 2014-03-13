require 'blue_print'

module BluePrint::Helper
  def within_cotext_of(name_or_context, &block)
    context = BluePrint::Context.resolve(name_or_context)

    return unless context.active?

    yield BluePrint.env
  end
end

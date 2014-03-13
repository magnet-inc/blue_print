require 'active_support/inflector'
require 'blue_print'
require 'blue_print/active_if'

class BluePrint::Context
  NAMED_CONTEXT_MAP = {}

  def self.inherited(klass)
    NAMED_CONTEXT_MAP[klass.context_name] = klass
  end

  def self.resolve(name)
    if name.respond_to?(:active?)
      return name
    else
      NAMED_CONTEXT_MAP[name.to_s.underscore.to_sym]
    end
  end

  def self.active_ifs
    @active_ifs ||= []
  end

  def self.active_if(*names, &logic)
    active_ifs.concat(
      names.map {|name| BluePrint::ActiveIf.resolve(name) }.reject(&:nil?)
    )
    active_ifs.push(BluePrint::ActiveIf.new(&logic)) if logic
  end

  def self.context_name
    @context_name ||= name.to_s.underscore.to_sym
  end

  def self.active?
    return BluePrint.env[context_name] if BluePrint.env.has_key?(context_name)

    BluePrint.env[context_name] = !!active_ifs.map(&:active?).inject { |memo, active|
      memo = memo && active
    }
  end

  def self.deactive?
    !active?
  end
end

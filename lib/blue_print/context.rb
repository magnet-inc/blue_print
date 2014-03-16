require 'active_support/inflector'
require 'blue_print'
require 'blue_print/active_if'

class BluePrint::Context
  def self.resolve(name)
    if name.respond_to?(:active?)
      return name
    else
      name.to_s.classify.sub(/(Context)?$/, 'Context').safe_constantize
    end
  end

  def self.active_ifs
    @active_ifs ||= []
  end

  def self.active_if(*names, &logic)
    active_ifs.concat(
      names.map { |name| BluePrint::ActiveIf.resolve(name) }.reject(&:nil?)
    )
    active_ifs.push(BluePrint::ActiveIf.new(&logic)) if logic
  end

  def self.context_name
    @context_name ||= name.to_s.underscore.to_sym
  end

  def self.active?
    BluePrint.env.fetch(context_name) do
      !!active_ifs.inject(active_ifs.first.try(:active?)) do |memo, active_if|
        memo && active_if.active?
      end
    end
  end

  def self.deactive?
    !active?
  end

  def self.activate!
    BluePrint.env[context_name] = true
  end

  def self.deactivate!
    BluePrint.env[context_name] = false
  end

  def self.casting
    @casting ||= Hash.new { |casting, klass| casting[klass] = [] }
  end

  def self.cast(actor, as: [])
    as = [as] unless as.kind_of?(Array)
    as.map! { |role| role.is_a?(Module) ? role : role.to_s.safe_constantize }
    casting[actor] = casting[actor] | as

    reaction!
  end

  def self.action!
    return if @acted

    casting.each_pair do |klass, roles|
      roles.each do |role|
        klass.send(:prepend, role)
      end
    end

    @acted = true
  end

  def self.reaction!
    @acted = false
    action!
  end
end

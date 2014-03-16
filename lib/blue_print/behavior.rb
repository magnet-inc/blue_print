require 'blue_print'
require 'blue_print/helper'

module BluePrint::Behavior
  def self.auto_generate_class_methods?(base)
    base.is_a?(Module) && !base.name.match(/ClassMethods$/)
  end

  def self.extended(base)
    if auto_generate_class_methods?(base)
      base.module_eval <<-EOC
        module ClassMethods
          extend BluePrint::Behavior
        end
      EOC
    end
  end

  def prepended(base)
    base.send(:include, BluePrint::Helper)

    if const_defined?('ClassMethods')
      singleton = class << base; self; end
      singleton.send(:prepend, const_get('ClassMethods'))
    end
  end

  def context_name
    @context_name ||= name.to_s.underscore.tap do |name|
      name.sub!(/\/class_methods$/, '')
      name.sub!(%r{/[^/]+?$}, '')
    end.to_sym
  end

  def context
    context_name.to_s.camelize.safe_constantize
  end

  def behavior_name
    @behavior_name ||=
      name.to_s.underscore.sub(/\/class_methods$/, '').gsub('/', '__').to_sym
  end

  def override_methods
    @override_methods ||= []
  end

  def define_safe_method(target, punctuation, method_name)
    alias_method("#{target}_with_#{behavior_name}#{punctuation}", method_name)

    module_eval <<-EOC
      def #{method_name}(*args)
        within_context_of(#{context}, proc { super(*args) }) do
          #{target}_with_#{behavior_name}#{punctuation}(*args)
        end
      end
    EOC
  end

  def method_added(method_name)
    return if @ignore_added_hook

    override_methods.push(method_name)

    @ignore_added_hook = true
    aliased_target = method_name.to_s.sub(/([?!=])$/, '')
    punctuation = Regexp.last_match ? Regexp.last_match[1] : ''

    define_safe_method(aliased_target, punctuation, method_name)

    context.reaction!
    @ignore_added_hook = false
  end
end

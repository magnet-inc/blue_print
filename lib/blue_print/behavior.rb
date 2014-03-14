require 'blue_print'
require 'blue_print/helper'

module BluePrint::Behavior
  include BluePrint::Helper

  def self.extended(base)
    if base.is_a?(Module) && !const_defined?('ClassMethods') && !base.name.match(/ClassMethods$/)
      base.module_eval <<-EOC
        module ClassMethods
          extend BluePrint::Behavior
        end
      EOC
    end
  end

  def prepended(base)
    if const_defined?('ClassMethods')
      singleton = class << base
        self
      end
      singleton.prepend(const_get('ClassMethods'))
    end
  end

  def context_name
    @context_name ||= name.to_s.underscore.tap { |name|
      name.sub!(%r{/class_methods$}, '')
      name.sub!(%r{/[^/]+?$}, '')
    }.to_sym
  end

  def context
    context_name.to_s.camelize.safe_constantize
  end

  def behavior_name
    @behavior_name ||=
      name.to_s.underscore.sub(%r{/class_methods$}, '').gsub('/', '__').to_sym
  end

  def override_methods
    @override_methods ||= []
  end

  def method_added(method_name)
    return if @ignore_added_hook

    override_methods.push(method_name)

    @ignore_added_hook = true
    aliased_target, punctuation = method_name.to_s.sub(/([?!=])$/, ''), $1

    alias_method "#{aliased_target}_with_#{behavior_name}#{punctuation}", method_name

    module_eval <<-EOC
      def #{method_name}(*args)
        if #{context.name}.active?
          #{aliased_target}_with_#{behavior_name}#{punctuation}(*args)
        else
          super
        end
      end
    EOC
    @ignore_added_hook = false
  end
end

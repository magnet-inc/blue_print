require 'thread_parent'
require 'blue_print/behavior'
require 'blue_print/version'
require 'blue_print/environment'
require 'blue_print/context'
require 'blue_print/helper'
require 'blue_print/integration'
require 'blue_print/railtie' if defined?(Rails)

module BluePrint
  def self.env
    Thread.current[:blue_print] ||= Thread.parents[:blue_print]
  end

  def self.env=(env)
    Thread.current[:blue_print] = env
  end

  def self.clear!
    Thread.current[:blue_print] = nil
  end
end

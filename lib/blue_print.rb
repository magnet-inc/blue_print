require 'thread_parent'
require 'blue_print/version'
require 'blue_print/behavior'
require 'blue_print/environment'
require 'blue_print/context'
require 'blue_print/helper'
require 'blue_print/integration'
require 'blue_print/railtie' if defined?(Rails)

module BluePrint
  ENV_KEY = :blue_print

  def self.env
    Thread.current[ENV_KEY] ||= Thread.parents[ENV_KEY]
  end

  def self.env=(env)
    Thread.current[ENV_KEY] = env
  end

  def self.clear!
    Thread.current[ENV_KEY] = nil
  end
end

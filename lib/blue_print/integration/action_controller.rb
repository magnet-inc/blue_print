require 'active_support/concern'
require 'blue_print/integration'
require 'blue_print/helper'

module BluePrint::Integration::ActionController
  extend ActiveSupport::Concern

  include BluePrint::Helper

  included do
    action_or_filter = respond_to?(:before_action) ? :action : :filter

    send("before_#{action_or_filter}", :build_blue_print_environment)
    send("after_#{action_or_filter}", :clear_blue_print_environment)
  end

  private

  def build_blue_print_environment
    BluePrint.env = BluePrint::Environment.new(self)
  end

  def clear_blue_print_environment
    BluePrint.clear!
  end
end

::ActionController::Base.send(
  :include,
  BluePrint::Integration::ActionController
)

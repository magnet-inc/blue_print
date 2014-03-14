require 'active_support/concern'
require 'blue_print/integration'
require 'blue_print/helper'

module BluePrint::Integration::ActionController
  extend ActiveSupport::Concern

  include BluePrint::Helper

  included do
    if respond_to?(:before_action)
      before_action(:build_blue_print_environment)
    else
      before_filter(:build_blue_print_environment)
    end

    if respond_to?(:after_action)
      after_action(:clear_blue_print_environment)
    else
      after_filter(:clear_blue_print_environment)
    end
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

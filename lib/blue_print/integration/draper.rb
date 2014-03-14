require 'blue_print/integration'
require 'blue_print/helper'

module BluePrint::Integration::Draper
  include BluePrint::Helper
end

Draper::Decorator.send(:include, BluePrint::Integration::Draper)

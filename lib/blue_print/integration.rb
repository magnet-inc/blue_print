require 'blue_print'

module BluePrint::Integration
end

begin
  require 'draper'
  require 'blue_print/integration/draper'
rescue LoadError
end

begin
  require 'grape'
  require 'blue_print/integration/grape'
rescue LoadError
end

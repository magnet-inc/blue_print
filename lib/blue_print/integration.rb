require 'blue_print'

module BluePrint::Integration
end

begin
  require 'draper'
  require 'blue_print/integration/draper'
rescue LoadError
end

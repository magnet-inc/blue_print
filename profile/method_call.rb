require 'blue_print'
require 'ruby-prof'

BluePrint.env = BluePrint::Environment.new({})

class Base
  def name
    :base
  end
end

class ProfileContext < BluePrint::Context
  module Extended
    def name
      :extended
    end
  end

  cast Base, as: Extended
end

ITERATION = 100000

RubyProf.start

ProfileContext.activate!
ITERATION.times do
  Base.new.name
end

ProfileContext.deactivate!
ITERATION.times do
  Base.new.name
end

result = RubyProf.stop

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT)

require 'blue_print'
require File.expand_path('../pure', __FILE__)

BluePrint.env = BluePrint::Environment.new(nil)

class Model
  def name
    :pure
  end
end

class BenchmarkContext < BluePrint::Context
  activate!

  module BenchmarkModel
    extend BluePrint::Behavior

    def name
      :blue_print
    end
  end

  cast Model, as: [BenchmarkModel]
end

model = Model.new

benchmark(
  :blue_print,
  -> { BenchmarkContext.activate! },
  -> { Model.new.name; NoEffect.new.name },
  -> { BenchmarkContext.deactivate! },
  -> { Model.new.name; NoEffect.new.name }
)

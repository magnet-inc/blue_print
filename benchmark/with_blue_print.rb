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

BLUE_PRINT_RESULT = []
progress = ProgressBar.create(
  title: model.name.to_s.ljust(LABEL_WIDTH),
  total: BENCHMARK_ITERATION
)
GC.start
BENCHMARK_ITERATION.times do |n|
  n += 1

  BLUE_PRINT_RESULT.push(
    Benchmark.measure("#{n}#{n.ordinal}") do
      BenchmarkContext.activate!

      NUM_ITERATION.times do
        Model.new.name
        NoEffect.new.name
      end

      BenchmarkContext.deactivate!

      NUM_ITERATION.times do
        Model.new.name
        NoEffect.new.name
      end
    end
  )

  progress.increment
end
progress.finish

require 'active_support/core_ext/integer/inflections'
require 'ruby-progressbar'
require 'benchmark'

LABEL_WIDTH = 10
BENCHMARK_ITERATION = 100
NUM_ITERATION = 100000

class Model
  def self.active?
    @active
  end

  def self.activate!
    @active = true
  end

  def self.deactivate!
    @active = false
  end

  def name
    if self.class.active?
      :pure
    else
      :pure
    end
  end
end

class NoEffect
  def name
    :no_effect
  end
end

model = Model.new

PURE_RESULT = []
progress = ProgressBar.create(
  title: model.name.to_s.ljust(LABEL_WIDTH),
  total: BENCHMARK_ITERATION
)
GC.start
BENCHMARK_ITERATION.times do |n|
  n += 1

  PURE_RESULT.push(
    Benchmark.measure("#{n}#{n.ordinal}") do
      Model.activate!

      NUM_ITERATION.times do
        Model.new.name
        NoEffect.new.name
      end

      Model.deactivate!

      NUM_ITERATION.times do
        Model.new.name
        NoEffect.new.name
      end
    end
  )

  progress.increment
end
progress.finish

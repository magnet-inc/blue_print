require 'active_support/core_ext/integer/inflections'
require 'ruby-progressbar'
require 'benchmark'

LABEL_WIDTH = 10
BENCHMARK_ITERATION = 100
NUM_ITERATION = 100000
SCORES = Hash.new { |h, k| h[k] = [] }

def benchmark(label, before_active, active, before_deactive, deactive)
  progress = ProgressBar.create(
    title: label.to_s.ljust(LABEL_WIDTH),
    total: BENCHMARK_ITERATION
  )
  GC.start
  BENCHMARK_ITERATION.times do |n|
    n += 1

    SCORES[label].push(
      Benchmark.measure("#{n}#{n.ordinal}") do
        before_active && before_active.call

        NUM_ITERATION.times do
          active.call
        end

        before_deactive && before_deactive.call

        NUM_ITERATION.times do
          deactive.call
        end
      end
    )

    progress.increment
  end
  progress.finish
end

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

DEFAULT_CALL = -> { Model.new.name; NoEffect.new.name }

benchmark(
  :pure,
  -> { Model.activate! },
  DEFAULT_CALL,
  -> { Model.deactivate! },
  DEFAULT_CALL
)

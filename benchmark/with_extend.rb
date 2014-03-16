require File.expand_path('../pure', __FILE__)

class Model
  def name
    :pure
  end
end

module ExtendedUser
  def name
    :extended
  end
end

model = Model.new.extend(ExtendedUser)

EXTEND_RESULT = []
progress = ProgressBar.create(
  title: model.name.to_s.ljust(LABEL_WIDTH),
  total: BENCHMARK_ITERATION
)
GC.start
BENCHMARK_ITERATION.times do |n|
  n += 1

  EXTEND_RESULT.push(
    Benchmark.measure("#{n}#{n.ordinal}") do
      NUM_ITERATION.times do
        Model.new.extend(ExtendedUser).name
        NoEffect.new.name
      end

      NUM_ITERATION.times do
        Model.new.name
        NoEffect.new.name
      end
    end
  )

  progress.increment
end
progress.finish

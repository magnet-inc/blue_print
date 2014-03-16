require 'bundler/gem_tasks'

desc 'Take benchmark'
task :benchmark do
  require File.expand_path('../benchmark/pure', __FILE__)
  require File.expand_path('../benchmark/with_blue_print', __FILE__)
  require File.expand_path('../benchmark/with_extend', __FILE__)

  result = {
    ruby: {
      version: RUBY_VERSION,
      platform: RUBY_PLATFORM
    },
    benchmark_iteration: BENCHMARK_ITERATION,
    method_call_iteration: NUM_ITERATION,
    benchmarks: {
      pure: PURE_RESULT,
      blue_print: BLUE_PRINT_RESULT,
      extend: EXTEND_RESULT
    }
  }

  result[:benchmarks].each_pair do |label, scores|
    puts "#{label}:"
    totals = scores.map(&:total)
    avg = totals.inject(&:+).to_f / totals.size
    puts "  min: #{totals.min.round(3)} max: #{totals.max.round(3)} avg: #{avg.round(3)}"
  end
end

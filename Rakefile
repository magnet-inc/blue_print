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
    benchmarks: SCORES
  }

  result[:benchmarks].each_pair do |label, scores|
    puts "#{label}:"
    totals = scores.map(&:total)
    avg = totals.inject(&:+).to_f / totals.size
    puts "  min: #{totals.min.round(3)} max: #{totals.max.round(3)} avg: #{avg.round(3)}"
  end
end

namespace :profile do
  PROFILES = Dir['profile/*.rb'].map {|f| File.basename(f, '.rb') }

  PROFILES.each do |profile|
    desc "take #{profile} profile"
    task profile do
      require File.expand_path("../profile/#{profile}", __FILE__)
    end
  end

  desc 'take all profiles'
  task :all do
    PROFILES.each do |profile|
      Rake::Task["profile:#{profile}"].invoke
    end
  end
end

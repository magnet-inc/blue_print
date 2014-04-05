ENV['RAILS_ENV'] ||= 'test'
require 'bundler/setup'

coverage = ENV['COV'].to_s
unless coverage == 'no'
  require 'simplecov'
  SimpleCov.start do
    require 'simplecov-console'
    require 'coveralls'

    add_filter '/spec'

    formatters = []
    formatters.push(SimpleCov::Formatter::Console)
    if coverage.include?('html')
      formatters.push(SimpleCov::Formatter::HTMLFormatter)
    end
    formatters.push(Coveralls::SimpleCov::Formatter)

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
  end
end

require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[File.expand_path('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
coverage = ENV['COV'].to_s
unless coverage == 'no'
  require 'simplecov'
  SimpleCov.start do
    require 'simplecov-console'

    add_filter '/spec'

    formatters = []
    formatters.push(SimpleCov::Formatter::Console)
    if coverage.include?('html')
      formatters.push(SimpleCov::Formatter::HTMLFormatter)
    end

    SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[*formatters]
  end
end

ENV['RAILS_ENV'] ||= 'test'

require 'bundler/setup'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[File.expand_path('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

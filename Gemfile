# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.0"

gem "thor"

group :test do
  gem "rspec"
  gem "rspec_junit_formatter"
  gem "simplecov", "< 0.18", require: false # FIXME: https://github.com/codeclimate/test-reporter/issues/418
end

group :development, :test do
  gem "pry"
  gem "pry-byebug"
  gem "rubocop"
end

gemspec

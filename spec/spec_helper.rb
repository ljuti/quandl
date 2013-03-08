gem 'rspec', '~> 2.4'
require 'rspec'
require_relative '../lib/quandl'

require "webmock/rspec"
require "vcr"
require "turn"

include Quandl

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
end
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require 'bigdecimal'
require 'csv'
SimpleCov.start
# Include future files that are required underneath SimpleCov, so it has started and they are tabulated in the coverage.
require './lib/merchant'
require './lib/item'

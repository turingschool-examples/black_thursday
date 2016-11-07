require 'simplecov'
SimpleCov.start do
  add_filter "test"
end
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'pry'
require './lib/sales_engine'
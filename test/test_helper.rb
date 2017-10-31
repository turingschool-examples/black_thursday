require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require './lib/merchant_repository'
require "./lib/merchant"
require "./lib/sales_engine"
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'csv'

require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/sales_engine"
require "pry"

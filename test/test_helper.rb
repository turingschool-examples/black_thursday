require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'csv'
require 'bigdecimal'
require 'time'

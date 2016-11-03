require 'simplecov'
SimpleCov.start do
  add_filter "test"
end
require 'minitest/autorun'
require 'minitest/nyan_cat'
require 'csv'
require 'pry'
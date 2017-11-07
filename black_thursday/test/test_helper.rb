require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'

SimpleCov.start do
  add_filter "../node_test.rb"
end

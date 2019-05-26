require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'minitest'
require "minitest/autorun"
require "minitest/pride"
require "mocha/mini_test"
require 'pry'

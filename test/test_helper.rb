require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require 'minitest'
require 'minitest/autorun'
require 'minitest/nyan_cat'

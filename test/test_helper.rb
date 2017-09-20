require 'simplecov'
Simplecov.start do
  add_filter "/test"
end
require 'minitest/autorun'
require 'minitest/pride'

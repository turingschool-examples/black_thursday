require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repo'
require './lib/item'
require './lib/merchant_repo'
require './lib/sales_engine'
require './lib/merchant'
require 'pry'

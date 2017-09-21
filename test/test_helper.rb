require 'simplecov'
SimpleCov.start do
  add_filter "../merchant_math_test.rb"
  add_filter "../merchant_test.rb"
  add_filter "../invoice_repository_test.rb"
  add_filter "../merchant_repository_test.rb"
  add_filter "../item_repository_test.rb"
  add_filter "../customer_test.rb"
  add_filter "../invoice_item_repository_test.rb"
  add_filter "../invoice_item_test.rb"
  add_filter "../invoice_test.rb"
  add_filter "../item_test.rb"
  add_filter "../sales_analyst_test.rb"
  add_filter "../sales_engine_test.rb"
  add_filter "../transaction_repository_test.rb"
  add_filter "../transaction_test.rb"
end

require "minitest/autorun"
require "minitest/pride"
require "pry"
require "csv"
require 'bigdecimal'
require 'time'

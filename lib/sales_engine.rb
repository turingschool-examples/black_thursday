require_relative 'merchant_repository'
require_relative 'item_repository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require 'csv'
require 'pry'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

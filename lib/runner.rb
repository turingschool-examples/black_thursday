require 'csv'
require './lib/sales_engine'

se = SalesEngine.new({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"
})
require "pry"; binding.pry
se.items

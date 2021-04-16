require 'CSV'
require './lib/sales_engine'
# require './data/items.csv'
# require './data/merchants.csv'

se = SalesEngine.new({
  :items => './data/items.csv',
  :merchants => './data/merchants.csv'
})

puts merchant_repo = se.merchant
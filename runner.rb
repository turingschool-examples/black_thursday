require "csv"
require_relative("./lib/sales_engine")
require "bigdecimal"

se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
require "pry"

binding.pry

# require 'csv'
# require './lib/sales_engine'
#
# se = SalesEngine.new({
#   :items     => CSV.read("./data/items.csv"),
#   :merchants => CSV.read("./data/merchants.csv"),
# })
#
# se.items
# mr = se.merchants
# merchant = mr.find_by_name

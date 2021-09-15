require 'csv'
require './lib/salesengine'

se = SalesEngine.new({
  :items     => CSV.read("./data/items.csv"),
  :merchants => CSV.read("./data/merchants.csv"),
})

se.items

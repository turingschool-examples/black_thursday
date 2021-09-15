require 'csv'
require './lib/salesengine_pa'

se = SalesEngine.new({
  :items     => CSV.read("./data/items.csv"),
  :merchants => CSV.read("./data/merchants.csv"),
})

se.merchants
require "pry"; binding.pry

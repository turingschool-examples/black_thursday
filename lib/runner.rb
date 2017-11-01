require './lib/sales_engine'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

merchant = se.merchants.find_by_id('12334112')
merchant.items

require_relative "../lib/sales_engine"
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'



se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

mr = se.merchants

p mr

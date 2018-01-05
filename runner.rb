require './lib/sales_engine'
require './lib/sales_analyst'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices  => "./data/invoices.csv"
})

merchant = se.merchants.find_by_id(12334159)
p merchant.invoices.class
p merchant.invoices.count

invoice = se.invoices.find_by_id(20)
p invoice.merchant.class

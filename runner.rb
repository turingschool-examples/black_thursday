require './lib/sales_engine'
require './lib/sales_analyst'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices  => "./data/invoices.csv"
})

sa = SalesAnalyst.new(se)

p sa.top_merchants_by_invoice_count.count

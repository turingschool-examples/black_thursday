require_relative 'sales_engine'
require_relative 'sales_analyst'
require 'pry'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices => "./data/invoices.csv"
})

# merchant = se.merchants.find_by_id(12334112)
# merchant.items
#
# item = se.items.find_by_id(263395237)
# item.merchant

sa = SalesAnalyst.new(se)

invoice = se.invoices.find_by_id(20)
puts invoice.merchant

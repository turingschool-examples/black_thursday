require_relative 'sales_engine'
require_relative 'sales_analyst'
require 'pry'

# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
#   :invoices => "./data/invoices.csv"
# })

se = SalesEngine.from_csv({
  :items     => "./test/fixtures/items_truncated.csv",
  :merchants => "./test/fixtures/merchants_truncated.csv",
  :invoices => "./test/fixtures/invoices_truncated.csv"
})

sa = SalesAnalyst.new(se)

p sa.golden_items

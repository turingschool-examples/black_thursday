require './lib/sales_engine'
require './lib/sales_analyst'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  :invoices  => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions => "./data/transactions.csv",
  :customers => "./data/customers.csv"
})


sa = SalesAnalyst.new(se)


p sa.merchants_with_only_one_item_registered_in_month("January").count
p sa.merchants_with_only_one_item_registered_in_month("March").count
p sa.merchants_with_only_one_item_registered_in_month("june").count

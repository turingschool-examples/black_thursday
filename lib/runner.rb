require_relative 'sales_engine'
require_relative 'sales_analyst'

se = SalesEngine.from_csv({
  :items         => "./data/items.csv",
  :merchants     => "./data/merchants.csv",
  :invoices      => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions  => "./data/transactions.csv",
  :customers     => "./data/customers.csv"
})

# se = SalesEngine.from_csv({
#   :items     => "./test/fixtures/items_truncated.csv",
#   :merchants => "./test/fixtures/merchants_truncated.csv",
#   :invoices => "./test/fixtures/invoices_truncated.csv",
#   :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
#   :transactions  => "./data/transactions.csv",
#   :customers     => "./data/customers.csv"
# })

sa = SalesAnalyst.new(se)

date = Time.parse("2009-02-07")

expected = sa.merchants_ranked_by_revenue

first = expected.first
last = expected.last

p expected.length

p first.id
p last.id

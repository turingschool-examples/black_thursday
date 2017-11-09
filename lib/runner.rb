require_relative 'sales_engine'
require_relative 'sales_analyst'
require "time"

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
#   :transactions => "./data/transactions.csv",
#   :customers => "./test/fixtures/customers_truncated.csv"
# })

sa = SalesAnalyst.new(se)



p se.find_invoice_by_invoice_id(1)

# date = Time.parse("2009-02-07")
#
# expected = sa.total_revenue_by_date(date)
#
# p expected.class
# p expected

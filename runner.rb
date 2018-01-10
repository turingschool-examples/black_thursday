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

p sa.average_items_per_merchant

# invoices =  se.find_invoice_by_merchant_id(12334105)
# paid_invoices = invoices.select do |invoice|
#   invoice.is_paid_in_full?
# end
# total = paid_invoices.reduce(0) do |sum, invoice|
#   sum += invoice.total
# end
# p total

# sa.top_revenue_earners(10).map do |merchant|
#     puts "#{merchant.id} #{merchant.total_revenue.class}"
#   end

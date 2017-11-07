require 'benchmark/ips'
require './lib/sales_analyst'


Benchmark.ips do |x|
  x.config(:item => 5, :warmup => 2)

  x.time = 5
  x.time = 2
  se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => './data/merchants.csv',
    :invoices => './data/invoices.csv',
    :customers => './data/customers.csv',
    :invoice_items => './data/invoice_items.csv',
    :transactions => './data/transactions.csv'
  })
  sa = SalesAnalyst.new(se)
  x.report('full-method') {sa.top_buyers}
  x.report('customer_invoices') {sa.customer_invoices}
  x.report('customer_spend') {sa.customer_spend(sa.customer_invoices)}

end

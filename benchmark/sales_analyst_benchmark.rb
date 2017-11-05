require 'benchmark/ips'
require './lib/sales_analyst'
# require 'descriptive_statistics'


Benchmark.ips do |x|
  x.config(:time => 5, :warmup => 2)

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
  x.report("std standard") {sa.standard_deviation_of_item_price_standard}
  x.report("std custom") {sa.standard_deviation_of_item_price}
end

"""
Warming up --------------------------------------
       average-items   162.389k i/100ms
count-items-merchant     1.000  i/100ms
accum-items-merchant   243.000  i/100ms
 average-items-stdev     1.000  i/100ms
   accum-items-stdev   187.000  i/100ms
Calculating -------------------------------------
       average-items      3.209M (± 3.6%) i/s -      6.496M in   2.027022s
count-items-merchant      2.991  (± 0.0%) i/s -      7.000  in   2.365541s
accum-items-merchant      1.934k (±24.7%) i/s -      3.645k in   2.027123s
average-items-stdev      3.130  (± 0.0%) i/s -      7.000  in   2.241187s
accum-items-stdev      1.800k (± 7.2%) i/s -      3.740k in   2.088667s
"""

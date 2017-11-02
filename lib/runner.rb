require './lib/sales_engine'
require './lib/sales_analyst'

se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})

# merchant = se.merchants.find_by_id(12334112)
# merchant.items
#
# item = se.items.find_by_id(263395237)
# item.merchant

sa = SalesAnalyst.new(se)

puts sa.unit_price_and_average_difference_squared_sum

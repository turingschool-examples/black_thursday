require_relative 'sales_engine'
require_relative 'sales_analyst'

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

# p sa.create_merchant_id_item_total_list
puts sa.average_item_price_for_merchant(12334149)

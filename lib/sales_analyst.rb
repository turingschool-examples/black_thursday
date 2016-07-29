
#
# se = SalesEngine.from_csv({
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
# merchant = se.merchants.find_by_id(10)
# merchant.items
# # => [<item>, <item>, <item>]
# item = se.items.find_by_id(20)
# item.merchant
# # => <merchant>

#this file fires up a sales engine

#methods:
  # sa.average_items_per_merchant # => 2.88

  #sa.average_items_per_merchant_standard_deviation # => 3.26

  #sa.merchants_with_high_item_count # => [merchant, merchant, merchant]

  #sa.average_item_price_for_merchant(6) # => BigDecimal

  #sa.average_average_price_per_merchant # => BigDecimal

# require_relative '../lib/item_repository'
#
# class SalesAnalyst
# end




# Do most of our merchants offer just a few items or do they represent a warehouse?
# sa.average_items_per_merchant # => 2.88


# And what's the standard deviation?
# sa.average_items_per_merchant_standard_deviation # => 3.26
# set = [3,4,5]
# std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )


# Which merchants are more than one standard deviation above the average number of products offered?
# sa.merchants_with_high_item_count # => [merchant, merchant, merchant]


# Let's find the average price of a merchant's items (by supplying the merchant ID):
# sa.average_item_price_for_merchant(6) # => BigDecimal


# sum all of the averages and find the average price across all merchants (this implies that each merchant's average has equal weight in the calculation):
# sa.average_average_price_per_merchant # => BigDecimal

require_relative './statistics'

class SalesAnalyst
  include Statistics

  def initialize(input)
    @merchants = input[:merchants]
    @items = input[:items]
  end

  def average_price_of_items
    tot_of_all_prices = @items.items.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    tot_of_all_prices / @items.items.count
  end

end
# sales_analyst.average_items_per_merchant # => 2.88 ~Maddie
# sales_analyst.average_items_per_merchant_standard_deviation # => 3.26 ~JC
# sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant] ~Jennica
# sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal ~Maddie
# sales_analyst.average_average_price_per_merchant # => BigDecimal ~Jennica
# sales_analyst.golden_items # => [<item>, <item>, <item>, <item>]  ~JC

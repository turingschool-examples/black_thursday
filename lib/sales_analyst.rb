require_relative './statistics'

class SalesAnalyst
  include Statistics

  def initialize(input)
    @merchants = input[:merchants]
    @items = input[:items]
  end

  def average_items_per_merchant
    items_by_merchant = @items.items.group_by { |item| item.merchant_id }
    item_count = items_by_merchant.inject(0) { |sum, n| n[1].count + sum }
    (item_count.to_f / items_by_merchant.count).round(2)
  end

end

# sales_analyst.average_items_per_merchant_standard_deviation # => 3.26 ~JC
# sales_analyst.merchants_with_high_item_count # => [merchant, merchant, merchant] ~Jennica
# sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal ~Maddie
# sales_analyst.average_average_price_per_merchant # => BigDecimal ~Jennica
# sales_analyst.golden_items # => [<item>, <item>, <item>, <item>]  ~JC

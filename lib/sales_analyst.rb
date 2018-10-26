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

  def average_price_of_items
    tot_of_all_prices = @items.items.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    tot_of_all_prices / @items.items.count
  end

  def golden_items
    number_set = @items.items.map do |item|
      item.unit_price_to_dollars
    end
    std_dev = standard_deviation(number_set)
    @items.items.find_all do |item|
      item.unit_price_to_dollars > average_price_of_items + 2 * std_dev
    end
  end

  def merchants_with_high_item_count
    item_count_by_merchant = items_by_merchant.map { |items| [items[0],items[1].count] }
    number_set = item_count_by_merchant.map { |item_count| item_count[1] }
    mean = find_mean(number_set)
    std = standard_deviation(number_set)
    item_count_by_merchant.find_all { |merchant| merchant[1] > std + mean }
  end

  def average_average_price_per_merchant
    find_mean(average_price_per_merchant).round(2)
  end

  def average_price_per_merchant
    items_by_merchant.map do |items|
      sum(items[1].map { |also_item| also_item.unit_price }) /items[1].count
    end
  end

  def items_by_merchant
    @items.items.group_by { |item| item.merchant_id }
  end
end

# sales_analyst.average_items_per_merchant_standard_deviation # => 3.26 ~JC
# sales_analyst.average_item_price_for_merchant(12334159) # => BigDecimal ~Maddie

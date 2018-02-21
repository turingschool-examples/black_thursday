#Business metadata calculator
class SalesAnalyst
  def initialize(sales_eng)
    @se = sales_eng
  end

  def average_items_per_merchant
    (@se.items.all.length.to_f / @se.merchants.all.length).round(2)
  end

  def items_for_each_merchant
    @se.merchants.all.map do |obj|
      @se.find_merchant_items(obj.id).length
    end
  end

  def square_differences
    items_for_each_merchant.map do |num|
      (num - average_items_per_merchant) ** 2
    end
  end

  def divided_sum
    square_differences.reduce(:+) / (@se.merchants.all.length - 1)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(divided_sum).round(2)
  end

  def one_std_deviation_item_count
    a = average_items_per_merchant_standard_deviation
    average_items_per_merchant + a
  end

  def merchants_with_high_item_count
    @se.merchants.all.find_all do |obj|
    end

    # Which merchants are more than one standard deviation above
    # the average number of products offered?
  end

  def average_item_price_for_merchant(id)
    x = @se.find_merchant_items(id).map { |obj| obj.unit_price }
    ( x.reduce(:+) / x.length ).round(2)
  end

  def total_avg_price
    @se.merchants.all.map do |obj|
      average_item_price_for_merchant(obj.id)
    end
  end

  def average_average_price_per_merchant
    (total_avg_price.reduce(:+) / @se.merchants.all.length).round(2)
  end

  def golden_items
    # two standard-deviations above the average item price
  end
end

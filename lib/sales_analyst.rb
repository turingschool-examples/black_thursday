#Business metadata calculator
class SalesAnalyst
  def initialize(sales_eng)
    @se = sales_eng
  end

  def average_items_per_merchant
    (@se.items.all.length.to_f / @se.merchants.all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation

  end

  def merchants_with_high_item_count
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

  # def golden_items
  # end
end

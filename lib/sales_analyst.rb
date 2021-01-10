require_relative './sales_engine'
require_relative './merchant_repo'
require_relative './item_repo'
require_relative './merchant'
require_relative './item'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.find_average
  end

  def average_items_per_merchant_standard_deviation
    @sales_engine.standard_deviation
  end

  def merchants_with_high_item_count
    @sales_engine.find_merchants_with_most_items
  end

  def convert_to_list(items)
    found = items.each_with_object([]) do |item, array|
      array << item.unit_price.to_f
      array
    end
    found
  end

  def average_item_price_for_merchant(id)
    items = @sales_engine.find_items_by_id(id)
    expected = convert_to_list(items).sum(0.0) / convert_to_list(items).size
    result = BigDecimal(expected, 4)
    result.div(100, 4)
  end

  def average_average_price_per_merchant
    result = @sales_engine.merchants.merchant_list.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    expected = result.sum(0.00) / result.size
    total_averages = BigDecimal(expected, 5).to_s("F")
    total_averages.to_f.floor(2)
  end
end

require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def items_per_merchant
    merchants_items = sales_engine.get_all_merchant_items
    merchants_items.map do |merchant_items|
      BigDecimal.new(merchant_items.count)
    end
  end

  def average_items_per_merchant
    items_per_merchant.sum / items_per_merchant.count
  end

  def average_items_per_merchant_standard_deviation
    variance = items_per_merchant.map do |number_of_items|
      ((average_items_per_merchant - number_of_items).abs) ** 2
    end.sum / (items_per_merchant.count - 1)
    Math.sqrt(variance)
  end

end

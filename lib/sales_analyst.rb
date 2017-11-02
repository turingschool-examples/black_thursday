require './lib/sales_engine'

class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine_from_csv)
    @sales_engine = sales_engine_from_csv
  end

  def average_items_per_merchant
    (total_items/total_merchants).round(2)
  end

  def total_merchants
    sales_engine.merchants.count
  end

  def total_items
    sales_engine.items.count
  end

  def average_items_per_merchant_standard_deviation

  end


  def merchants_with_high_item_count

  end


  def average_item_price_for_merchant(merchant_id)

  end

  def average_average_price_per_merchant

  end

  def golden_items

  end

end

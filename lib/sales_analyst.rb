require './lib/sales_engine'

class SalesAnalyst

  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    se.total_items / se.total_merchants
  end

  def average_items_per_merchant_standard_deviation
    
  end

  def merchants_with_high_item_count

  end

  def merchants_with_high_item_count
  end

  def average_item_price_for_merchant(id)

  end

  def average_price_per_merchant

  end

  def golden_items

  end
end

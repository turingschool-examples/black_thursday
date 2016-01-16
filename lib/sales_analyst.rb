require_relative 'sales_engine'

class SalesAnalyst < SalesEngine

  def initialize(se = nil)
    @se = se
  end

  def average_items_per_merchant

  end

  def average_items_per_merchant_standard_deviation
    #this gem will allow us to use the standard deviation
  end

  def merchants_with_low_item_count

  end

  def average_item_price_for_merchant

  end

  def average_price_per_merchant

  end

  def golden_items

  end
end

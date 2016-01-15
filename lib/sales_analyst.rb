require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :se
  include Enumerable

  def initialize(se = SalesEngine.new)
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

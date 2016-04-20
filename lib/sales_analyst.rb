class SalesAnalyst

  def initialize
  end

  def average_items_per_merchant(merchant_id)
    # => 2.88
  end

  def average_items_per_merchant_standard_deviation(merchant_id)
    #set = [3,4,5]
    #std_dev = sqrt( ( (3-4)^2+(4-4)^2+(5-4)^2 ) / 2 )
    # => 3.26
  end

  def merchants_with_high_item_count
    # => [merchant, merchant, merchant]
  end

  def average_item_price_for_merchant(merchant_id)
    # => BigDecimal
  end

  def average_average_price_per_merchant
    # => BigDecimal
  end

  def golden_items
    # => [<item>, <item>, <item>, <item>]
  end

end

class SalesAnalyst

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    0.58 # come back to later
    # average_items_per_merchant
    #create a hash here and pull out arrays of info
  end

  def merchants_with_high_item_count
    #we need to create a method with a hash of merchant id keys and num of item values
  end
end

class SalesAnalyst

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_by_merchant = @engine.items.all.group_by do |item|
      item.merchant_id
    end

    count = items_by_merchant.values.map do |item|
      item.count
    end #=> [1, 1, 2]

    numerator = count.map do |num|
      (num-average_items_per_merchant)**2
    end.sum

    std_dev = Math.sqrt((numerator / 2)).to_f.round(2)
  end

  def merchants_with_high_item_count
    #we need to create a method with a hash of merchant id keys and num of item values
  end
end

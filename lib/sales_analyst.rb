class SalesAnalyst

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def merch_items_hash
    merch_items = {}

    @engine.merchants.all.map do |merchant|
      merch_items[merchant.id] = @engine.items.find_all_by_merchant_id(merchant.id)
    end

    merch_items
  end

  def items_by_merch_count
    merch_items_hash.values.map do |item|
      item.count
    end
  end

  def average_items_per_merchant_standard_deviation
    numerator = items_by_merch_count.sum do |num|
      (num-average_items_per_merchant)**2
    end

    std_dev = Math.sqrt(numerator / 2.0).round(2)
  end

  def merchants_with_high_item_count
    merch_items_hash.select do |merch_id, items|
      items.length > (average_items_per_merchant + average_items_per_merchant_standard_deviation) # 6 items > 1.33 mean + .58 std dev
    end
  end
end

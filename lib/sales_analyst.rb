class SalesAnalyst

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    require "pry"; binding.pry
    (@engine.items.all.length / @engine.merchants.all.length.to_f).round(2)
  end

  def merch_items_hash
    merch_items = {}
    # could use merchant as the key instead of the ID in case we need to call upon the object in the future?
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
      (num - average_items_per_merchant) ** 2
    end
    denominator = (items_by_merch_count.length - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end

  def merchants_with_high_item_count
    merch_high_count = merch_items_hash.select do |merch_id, items|
      items.length > (average_items_per_merchant + average_items_per_merchant_standard_deviation) # 6 items > 1.33 mean + .58 std dev
    end
    merch_high_count.keys.map do |merch_id|
      @engine.merchants.find_by_id(merch_id)
    end
  end

  def price_of_items_for_merch(merchant_id)
    merch_items_hash[merchant_id].map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(merchant_id)
    (price_of_items_for_merch(merchant_id).sum / price_of_items_for_merch(merchant_id).length).round(2)
  end

  def average_average_price_per_merchant
    avg_price_per_merch = merch_items_hash.keys.map do |id|
      average_item_price_for_merchant(id)
    end
    (avg_price_per_merch.sum / avg_price_per_merch.length).floor(2)
  end

  def item_price_set
    @engine.items.all.map do |item|
      item.unit_price_to_dollars
    end
  end

  def average_price_per_item
    (item_price_set.sum / item_price_set.length).round(2)
  end

  def average_price_per_item_standard_deviation
    numerator = item_price_set.sum do |num|
      (num - average_price_per_item) ** 2
    end
    denominator = (item_price_set.length - 1).to_f
    Math.sqrt(numerator / denominator).round(2)
  end

  def golden_items
    @engine.items.all.select do |item|
      # 28 items > 13.5 mean + 10.86 std dev times 2
      item.unit_price_to_dollars > (average_price_per_item +
        (average_price_per_item_standard_deviation * 2))
    end
  end
end

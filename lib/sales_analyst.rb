class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def merchant_count # this method counts all merchants
    engine.merchants.all.count
  end

  def item_count # this method counts all items
    engine.items.all.count
  end

  def merchant_items_count(merchant_id) # meth counts all items a merchant has
    engine.items.find_all_by_merchant_id(merchant_id).count
  end

  def average_items_per_merchant # meth calculates teh avg using the methods created above
    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation # meth calcs std deviation using meths avobe
    total = engine.merchants.all.map do |merchant|
      ((merchant_items_count(merchant.id)) - average_items_per_merchant)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2)
  end

  def merchants_with_high_item_count # returns arr of merchs with item count 1 std dev more than avg
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    engine.merchants.all.find_all do |merchant|
      merchant_items_count(merchant.id) > (std_dev + avg)
    end
  end

  def merchant_items(merchant_id) # meth finds all items of merch by merch id
    engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_item_price_for_merchant(merchant_id) # meth find avg item price for a gvien merchant
    total = merchant_items(merchant_id).map do |item|
      item.unit_price
    end
    (total.reduce(:+)/total.length).round(2)
  end

  def average_average_price_per_merchant
    averages = engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.reduce(:+)/averages.length).round(2)
  end

end

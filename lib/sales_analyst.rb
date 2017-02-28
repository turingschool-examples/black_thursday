class SalesAnalyst
  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def merchant_count # this method counts all merchants
    engine.merchants.all.count # pulls up merchant repo from engine, calls all to get array, and counts it
  end

  def item_count # this method counts all items
    engine.items.all.count # counts all items in item repo array of item objects
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
    end # sets total to arr find diff of each item total per merchant and teh average item total of merchants, squares this
    Math.sqrt(total.reduce(:+)/(total.length-1)).round(2) # sums squares together, divides by number of elemetns -1, squares the result
  end

  def merchants_with_high_item_count # returns arr of merchs with item count 1 std dev more than avg
    std_dev = average_items_per_merchant_standard_deviation # sets local var to result of above
    avg = average_items_per_merchant
    engine.merchants.all.find_all do |merchant|
      merchant_items_count(merchant.id) > (std_dev + avg) # returns arr of all merchants whose count is greater than 1 std dev above average
    end
  end

  def merchant_items(merchant_id) # meth finds all items of merch by merch id
    engine.items.find_all_by_merchant_id(merchant_id)
  end

  def average_item_price_for_merchant(merchant_id) # meth find avg item price for a gvien merchant
    total = merchant_items(merchant_id).map do |item|
      item.unit_price # sets total to arr of item prices
    end
    (total.reduce(:+)/total.length).round(2) # sums those elements, divids by length
  end

  def average_average_price_per_merchant # avg of all merchants avg prices, weighted equally
    averages = engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id) # sets local var to arr of averages of each merchant
    end
    (averages.reduce(:+)/averages.length).round(2) # sums those avgs, divides by no. of averages, and rounds
  end

  def average_item_price # method to find avg of all item prices, to be used for std dev of item price and then golden items
    total = engine.items.all.map do |item|
      item.unit_price # sets total to arr of each item's unit price
    end
    (total.reduce(:+)/total.length.to_f) # finds average
  end

  def standard_deviation_item_price # method finds std dev, same as above but with items
    total = engine.items.all.map do |item|
      (item.unit_price - average_item_price)**2
    end
    Math.sqrt(total.reduce(:+)/(total.length-1))
  end

  def golden_items # finds items two std dev above avg item price
    std_dev = standard_deviation_item_price # sets std dev to result of method above
    engine.items.all.find_all do |item|
      item.unit_price > (std_dev * 2) # returns array of all items with the above condition
    end
  end

end

class SalesAnalyst
  attr_reader :engine
  
  def initialize(engine="")
    @engine = engine
  end
  
  def average_items_per_merchant
    (engine.items.all.count/engine.merchants.all.count.to_f).round(2)
  end
  
  def average_items_per_merchant_standard_deviation
    # array each items/merchant (total count = merchants.all)
    # average
    # merchants.all.count - 1
    set = engine.merchants.all.map do |merchant|
      merchant.items.count
    end
    squared_differences = set.map { |num| (num - average_items_per_merchant)**2 }
    
    (Math.sqrt( ( squared_differences.reduce(:+) ) / (set.count - 1) )).round(2)
    # Math.sqrt( ( (2-0.67)**2+(0-0.67)**2+(0-0.67)**2 ) / 2 )
  end
  
  def merchants_with_high_item_count
    engine.merchants.all.select do |merchant| 
      merchant.items.count > (average_items_per_merchant_standard_deviation + average_items_per_merchant) 
    end
  end
  
  def average_item_price_for_merchant(merch_id)
    total_price = engine.merchants.find_by_id(merch_id).items.reduce(0) do |total, item|
      total + item.unit_price
    end
    total_price / engine.merchants.find_by_id(merch_id).items.count
  end
  
  def average_average_price_per_merchant
    engine.merchants.all.reduce(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end.send('/', engine.merchants.all.count)
  end
  
  def average_item_price
    engine.items.all.reduce(0) do |total, item|
      total + item.unit_price_to_dollars
    end.send('/', engine.items.all.count).round(2)
  end
  
  def item_price_standard_deviation
    set = engine.items.all.map do |item|
      item.unit_price_to_dollars
    end
    
    squared_differences = set.map { |num| (num - average_item_price)**2 }
    std_dev = (Math.sqrt( ( squared_differences.reduce(:+) ) / (set.count - 1) )).round(2)
  end
  
  def golden_items
    engine.items.all.select do |item| 
      item.unit_price_to_dollars > (item_price_standard_deviation * 2 + average_item_price) 
    end
  end
  
end
class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def find_all_merchants
    @engine.merchants.array_of_objects
  end

  def find_all_items
    @engine.items.array_of_objects
  end

  def get_merchant_ids(merchants)
    merchants.map do |merchant|
      merchant.id
    end
  end

  def average_items_per_merchant(merchant_ids)
    item_counter = 0
    merchant_ids.each do |merchant_id|
      item_counter += find_all_items_by_merchant_id(merchant_id).length
    end

    average = item_counter / merchant_ids.length.to_f
    average.truncate(2)
  end

  def sample_merchants_return_id
    merch_sample = find_all_merchants.sample(10)
    get_merchant_ids(merch_sample)
  end

  def stnd_dev_of_merch_items
    merchant_items = []
    sample_merchants_return_id.each do |merchant_id|
      merchant_items << find_all_items_by_merchant_id(merchant_id).length
    end
    sample_size_minus_one = merchant_items.length - 1
    counter = 0
    merchant_items.each do |number|
      running_total = (number - average_items_per_merchant(sample_merchants_return_id))**2 
      counter += running_total
    end
    Math.sqrt(counter / sample_size_minus_one)
  end

  def find_all_items_by_merchant_id(merchant_id)
    find_all_items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end

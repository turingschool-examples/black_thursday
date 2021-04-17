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

  def average_items_per_merchant
    merchants = find_all_merchants
    merchant_ids = get_merchant_ids(merchants)
    item_counter = 0
    merchant_ids.each do |merchant_id|
      item_counter += find_all_items_by_merchant_id(merchant_id).length
    end
    average = item_counter / merchant_ids.length.to_f
    average.round(2)
  end

  def sample_merchants_return_id
    # Need to revisit based on instructor input; seems to require full data set
    merch_sample = find_all_merchants.sample(10)
    get_merchant_ids(merch_sample)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = []
    sample_merchants_return_id.each do |merchant_id|
      merchant_items << find_all_items_by_merchant_id(merchant_id).length
    end
    sample_size_minus_one = merchant_items.length - 1
    counter = 0
    merchant_items.each do |number|
      running_total = (number - average_items_per_merchant)**2
      counter += running_total
    end
    Math.sqrt(counter / sample_size_minus_one)
  end

  def find_all_items_by_merchant_id(merchant_id)
    find_all_items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def merchants_with_high_item_count
    merchants = find_all_merchants
    merchant_ids = get_merchant_ids(merchants)
    mean = average_items_per_merchant
    half_stnd_dev = average_items_per_merchant_standard_deviation / 2
    greater_than_1sd = mean + half_stnd_dev
    merchants.find_all do |merchant|
      find_all_items_by_merchant_id(merchant.id).length > greater_than_1sd
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = find_all_items_by_merchant_id(merchant_id)
    sum_of_merchant_prices = merchant_items.sum do |item|
      item.unit_price
    end
    if merchant_items.length == 0
      0
    else
      (sum_of_merchant_prices / merchant_items.length).round(2)
    end
  end

  def average_average_price_per_merchant
    merchant_count = find_all_merchants.length
    items_sum = find_all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (items_sum / merchant_count).round(2)
  end

  def golden_items
    sum = find_all_items.sum do |item_object|
      item_object.unit_price
    end
    mean = sum / find_all_items.length
    twice_half_stnd_dev = (average_items_per_merchant_standard_deviation / 2)*2
    greater_than_2sd = mean + twice_half_stnd_dev
    test = find_all_items.find_all do |item|
      item.unit_price > greater_than_2sd
    end
  end
end

require_relative 'compute'

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

  def average_items_per_merchant_standard_deviation
    merchant_items = []
    find_all_merchants.each do |merchant|
      merchant_items << find_all_items_by_merchant_id(merchant.id).length
    end
    population_size_minus_one = merchant_items.length - 1
    counter = 0
    merchant_items.each do |number|
      running_total = (number - average_items_per_merchant)**2
      counter += running_total
    end
    Math.sqrt(counter / population_size_minus_one).round(2)

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
    greater_than_1sd = mean + average_items_per_merchant_standard_deviation
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
      Compute.mean(sum_of_merchant_prices, merchant_items.length)
    end
  end

  def average_average_price_per_merchant
    merchant_count = find_all_merchants.length
    items_sum = find_all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    Compute.mean(items_sum, merchant_count)
  end

  def average_price_per_item_standard_deviation
    sum = find_all_items.sum do |item_object|
      item_object.unit_price
    end
    mean = Compute.mean(sum, find_all_items.length)

    population_size_minus_one = find_all_items.length - 1
    counter = 0
    find_all_items.each do |item|
      running_total = (item.unit_price - mean)**2
      counter += running_total
    end
    Math.sqrt(counter / population_size_minus_one).round(2)
  end

  def golden_items
    sum = find_all_items.sum do |item_object|
      item_object.unit_price
    end
    mean = sum / find_all_items.length
    two_sd = average_price_per_item_standard_deviation * 2
    greater_than_2sd = mean + two_sd
    accumulator = []
    find_all_items.each do |item|
      if item.unit_price >= greater_than_2sd
        accumulator << item
      end
    end
    accumulator
  end

  ##### INVOICE ITERATION 2 ######

  def average_invoices_per_merchant
    Compute.mean(number_of_all_invoices, get_merchant_ids(find_all_merchants).length)
  end

  def find_all_invoices
    @engine.invoices.array_of_objects
  end

  def number_of_all_invoices
    find_all_invoices.length
  end

end

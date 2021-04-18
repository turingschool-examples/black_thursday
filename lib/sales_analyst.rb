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

  def find_all_items_by_merchant_id(merchant_id)
    find_all_items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def items_per_merchant
    items_per_merchant =  []
    find_all_merchants.each do |merchant|
      items_per_merchant << find_all_items_by_merchant_id(merchant.id).length
    end
    items_per_merchant
  end

  def average_items_per_merchant
    Compute.mean(items_per_merchant.sum, items_per_merchant.length)
  end

  def average_items_per_merchant_standard_deviation
    adder_counter = items_per_merchant.sum do |number|
      (number - average_items_per_merchant)**2
    end
    Math.sqrt(adder_counter / (items_per_merchant.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    greater_than_1sd = mean + average_items_per_merchant_standard_deviation
    find_all_merchants.find_all do |merchant|
      find_all_items_by_merchant_id(merchant.id).length > greater_than_1sd
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = find_all_items_by_merchant_id(merchant_id)
    sum_of_prices = merchant_items.sum do |item|
      item.unit_price
    end
    if merchant_items.length != 0
      Compute.mean(sum_of_prices, merchant_items.length)
    else
      0
    end
  end

  def average_average_price_per_merchant
    items_sum = find_all_merchants.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    Compute.mean(items_sum, find_all_merchants.length)
  end

  def total_item_price
    sum = find_all_items.sum do |item_object|
      item_object.unit_price
    end
  end

  def average_price_per_item_standard_deviation
    total_number_of_items = find_all_items.length
    mean = Compute.mean(total_item_price, total_number_of_items)
    adder_counter = find_all_items.sum do |item|
      (item.unit_price - mean)**2
    end
    Math.sqrt(adder_counter / (total_number_of_items - 1)).round(2)
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
  def find_all_invoices
    @engine.invoices.array_of_objects
  end

  def number_of_all_invoices
    find_all_invoices.length
  end

  def average_invoices_per_merchant
    test = Compute.mean(invoices_per_merchant.sum, invoices_per_merchant.length)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    find_all_invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def invoices_per_merchant
    invoices_per_merchant =  []
    find_all_merchants.each do |merchant|
      if
        invoices_per_merchant << find_all_invoices_by_merchant_id(merchant.id).length
      end
    end
    invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    adder_counter = invoices_per_merchant.sum do |number_of_invoices|
      (number_of_invoices - average_invoices_per_merchant)**2
    end
    Math.sqrt(adder_counter.to_f / (invoices_per_merchant.length - 1)).round(2)
  end


###THIS IS FOR THE NEXT PART OF ITERATION 2###
  # def merchants_with_high_item_count
  #   mean = average_items_per_merchant
  #   greater_than_1sd = mean + average_items_per_merchant_standard_deviation
  #   find_all_merchants.find_all do |merchant|
  #     find_all_items_by_merchant_id(merchant.id).length > greater_than_1sd
  #   end
  # end
end

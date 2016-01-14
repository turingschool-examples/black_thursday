require_relative 'sales_engine'
# require 'enumerable/standard_deviation'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_number_of_merchants
    # use enum .inject instead of .count
    @sales_engine.merchants.all.count
  end

  def total_number_of_items
    @sales_engine.items.all.count
  end

  def average_items_per_merchant
    average = total_number_of_items / total_number_of_merchants.to_f
    average.round(1)
  end

  def all_merchant_id_numbers
    all_items = @sales_engine.items.all
    all_items.map do |item|
      item.merchant_id
    end
  end

  def item_counts_for_each_merchants
    id_count_pairs = all_merchant_id_numbers
    id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }.values
  end

  def combine_merchant_item_count
    item_counts = item_counts_for_each_merchants
    avg = 2.9
    item_counts.map {|item| (item - avg) ** 2}
  end

  def average_items_per_merchant_standard_deviation
    # calc the mean
    # => .average_items_per_merchant
    # subtract the mean from each item & square result
    # => .combine_merchant_item_count
    # find mean of resulting numbers (the result of .combine_merchant_item_count)
    element = combine_merchant_item_count
    element_mean = element.inject(0,:+) / element.count
    # => calc the square root of the mean


    #array of items.merchant_id.uniq
  end


  # Which are our 'Golden Items'?

end

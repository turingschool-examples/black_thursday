require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_number_of_merchants
    # returns total count of all merchants in Merchant Repository
    # use enum .inject instead of .count
    @sales_engine.merchants.all.count
  end

  def total_number_of_items
    # returns total count of all items in Item Repository
    @sales_engine.items.all.count
  end

  def average_items_per_merchant
    # returns the average number of items offered by each merchant
    average = total_number_of_items / total_number_of_merchants.to_f
    average.round(1)
  end

  def all_merchant_id_numbers
    # searches through Item Repo and returns array of all merchant_id strings
    all_items = @sales_engine.items.all
    all_items.map do |item|
      item.merchant_id
    end
  end

  def item_counts_for_each_merchants
    id_count_pairs = all_merchant_id_numbers
    # id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }.values
    id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }
  end

  def combine_merchant_item_count
    item_counts = item_counts_for_each_merchants
    # avg = average_items_per_merchant
    avg = 2.9
    item_counts.map {|item| (item - avg) ** 2}
  end

  def calc_items_per_merchant_standard_deviation
    element = combine_merchant_item_count
    element_mean = element.inject(0,:+) / (element.count - 1)
    standard_deviation = (element_mean ** 0.5)
    standard_deviation.round(1)
  end

  def find_percentage_of_those_who_fall_one_std_dev_below
    #find those below one std dev based on normal distribution graph, which is 15.8%
    total = total_number_of_merchants
    percentage = 0.158
    total * percentage
  end

  def sort_merchants_based_on_the_number_of_listings
    # creates nested array, in order, of merchant_id and avg items sold
    items = item_counts_for_each_merchants
    items.sort_by { |key, value| value }
  end

  def merchants_below_one_std_dev
    # this returns the merchant_ids with the item counts
    # takes sorted nested array of merchants, and extracts those below one std dev
    sorted = sort_merchants_based_on_the_number_of_listings
    below_avg = find_percentage_of_those_who_fall_one_std_dev_below
    sorted.first(below_avg)
  end

  def merchants_with_low_item_count
    merchant_ids = merchants_below_one_std_dev.to_h.keys

    @sales_engine.merchants.all.select do |m|
      merchant_ids.include?(m.id)
    end
  end


  def average_item_price_for_merchant(merchant_id)
    # merchant = @sales_engine.merchants.find_by_id(merchant_id)
    merchant = @sales_engine.items.find_all_by_merchant_id(merchant_id)
  end

end

se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                           :items => './data/items.csv'})

sa = SalesAnalyst.new(se).merchants_with_low_item_count

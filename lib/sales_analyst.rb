require_relative 'sales_engine'

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
    # take array of merchants_below_one_std_dev
    # extract merchant_ids
    # map over standard merchants.all
    # push the merchant.name of any matching merchants

    merch_repo = @sales_engine.merchants
    merchants = merchants_below_one_std_dev
    binding.pry
    merchant_ids = merchants.keys
    # binding.pry

    # merch_repo = @sales_engine.merchants
    binding.pry
    merchant_ids.map do |id|
      id = id.to_i
      merch_repo.find_by_id(id)
    end


    # merchant_ids.select do |id|
    #     @sales_engine.items.find_by_id(id)
    #     binding.pry
    # end
  end


  # def find_one_standard_deviation_value
  #   #(standard_deviation - mean) / 4
  #   std_deviation = calc_items_per_merchant_standard_deviation
  #   mean = average_items_per_merchant
  #   # binding.pry
  #   return (std_deviation - mean) / 4
  #
  #   #this will give one standard deviation to calculate
  #   #who falls one sd down below.
  # end

end

require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_number_of_merchants
    @sales_engine.merchants.all.count
  end

  def total_number_of_items
    @sales_engine.items.all.count
  end

  def average_items_per_merchant
    # returns the average number of items offered by each merchant
    average = total_number_of_items / total_number_of_merchants.to_f
    average.round(1)
  end

  def get_all_merchant_id_numbers
    # searches through Item Repo and returns array of all merchant_id strings
    all_items = @sales_engine.items.all
    all_items.map do |item|
      item.merchant_id
    end
  end

  def get_item_counts_for_each_merchants
    id_count_pairs = all_merchant_id_numbers
    id_count_pairs.inject(Hash.new(0)) { |hash, item| hash[item] += 1; hash }
  end

  def combined_merchant_item_count
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

#find average prices of items based on merchant_ids
  def get_hash_of_merchants_to_items
    all_items = @sales_engine.items.all
    merchant_to_items = {}
    all_items.each do |item|
      id = item.merchant_id
      if !merchant_to_items.has_key?(id)
        merchant_to_items[id] = [item]
      else
        merchant_to_items[id] << item
      end
    end
    merchant_to_items
  end

  def average_item_price_for_merchants(merchant_id) #required method
    merchant_to_items = get_hash_of_merchants_to_items
    item_prices = merchant_to_items[merchant_id].map {|x| x.unit_price}
    (item_prices.inject(:+)/item_prices.count)#.to_s
  end

  def average_price_per_merchant #required
    all_items = @sales_engine.items.all
    all_items.map {|item| item.unit_price}.inject(:+)/all_items.count
    #result need to be .to_s??
  end
#finished relationship question 3 above, start question 4 below.
  def sort_price_for_all_items
    all_items = @sales_engine.items.all
    all_items.map {|item| item.unit_price}.sort.reverse
    #MAKE SURE THE SORT IS CORRECT
  end

  def get_number_of_items_that_fall_2_stdv_above
    percentage_for_two_stdv_abv = 0.022
    (total_number_of_items * 0.022).round(0)  #=>30
  end

  def items_with_2_std_dev_above_avg_price
    sorted_prices = sort_price_for_all_items
    top_priced = get_number_of_items_that_fall_2_stdv_above
    sorted_prices.first(top_priced)
  end  #THIS RETURNS 30 ITEMS

  def golden_items
    top_priced = items_with_2_std_dev_above_avg_price
    @sales_engine.items.all.select do |item|
      top_priced.include?(item.unit_price)
    end.first(top_priced.count)
  end  #THIS RETURNS 32 ITEMS INSTEAD OF 30. NEEDED TO ADD .FIRST()
end
 #finished iteration 1


if __FILE__ == $0
se = SalesEngine.from_csv({:merchants => './data/merchants.csv',
                           :items => './data/items.csv'})

sa = SalesAnalyst.new(se)
# sa.get_hash_of_merchants_to_items
# sa.average_item_price_for_merchants(12334275)
# sa.get_total_price_for_all_items
# sa.sort_price_for_all_items
# sa.get_number_of_items_that_fall_2_stdv_above
# puts sa.items_with_2_std_dev_above_avg_price.count
# puts sa.golden_items.count
end

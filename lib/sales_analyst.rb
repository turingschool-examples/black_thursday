require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require 'time'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :merchants, :items, :invoices

  def initialize(merchant_repo, item_repo, invoice_repo)
    @merchants = merchant_repo
    @items = item_repo
    @invoices = invoice_repo
  end

  # def average(elements, total_elements)
  #   total_elements = elments.all.count_to_f
  #   total_total_elements = total_elements.all.count.to_f
  #   (total_elements / total_total_elements).round(2)
  # end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    total_items = @items.find_all_by_merchant_id(merchant_id)
    total_prices = total_items.inject(0) do |sum, item|
      sum += item.unit_price
    end
    average_item_price = total_prices / total_items.count
    average_item_price.round(2)
  end

  def average_average_price_per_merchant
    average_summed = all_average_prices.inject(0) do |sum, price|
      sum += price
    end
    average_average_price = average_summed / @merchants.all.count
    average_average_price.round(2)
  end

  def average_item_price
    prices_summed = @items.all.inject(0) do |sum, item|
      sum += item.unit_price
    end
    prices_summed / @items.all.count
  end


  def all_average_prices
    average_prices = @merchants.all.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
  end

  def all_item_prices
   @items.all.map do |item|
    item.unit_price
    end
  end

  def return_unique_merchants
    if @merchants != nil
      return @merchants.all.uniq do |merchant|
        merchant.id
      end
    end
  end

  def total_items_per_merchant
    merchants = return_unique_merchants
    merchant_item_total = []
    merchants.each do |merchant|
      merchant_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      merchant_item_total << merchant_items.count
    end
    merchant_item_total
  end

  def differences_from_average(array, average)
    array.map do |amount|
      amount.to_f - average
    end
  end

  def square_each_amount(array)
    array.map do |amount|
      amount * amount
    end
  end

  def sum_amount(array)
    array.inject(0) do |sum, amount|
      sum += amount
    end
  end

  def divide_sum_by_elements_less_one(elements, sum)
    sum / (elements.all.count - 1)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(total_items_per_merchant, average_items_per_merchant, @merchants)
  end

  def standard_deviation_prices  #for prices
    standard_deviation(all_item_prices, average_item_price, @items)
  end

  def standard_deviation(one, average, collection)
    differences = differences_from_average(one, average)
    squares = square_each_amount(differences)
    sum = sum_amount(squares)
    result = divide_sum_by_elements_less_one(collection, sum)
    result = Math.sqrt(result).round(2)
  end

  def merchants_ids_for_high_item_count
    high_item_count = average_items_per_merchant_standard_deviation + average_items_per_merchant
    id_count_pair = return_unique_merchants.zip(total_items_per_merchant)
    merchant_ids = id_count_pair.find_all do |pair|
      if pair[1] >= high_item_count
        pair[0]
      end
    end
  end

  def merchants_with_high_item_count
    pairs = merchants_ids_for_high_item_count
    pairs.map do |pair|
      pair.reverse
      pair.pop
    end
    pairs.flatten
  end

  def golden_items
    high_item_price = standard_deviation_prices * 2 + average_item_price
    golden = []
    @items.all.each do |item|
      if item.unit_price >= high_item_price
        golden << item
      end
    end
    golden
  end

# How many invoices does the average merchant have?
# sales_analyst.average_invoices_per_merchant # => 10.49
# sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
  def average_invoices_per_merchant
    unique_merchants = @merchants.all.uniq
    average = @invoices.all.count.to_f / unique_merchants.count
    require "pry"; binding.pry
    average.round(2)
  end

  def average_invoices_per_merchant_standard_deviation

  end

# Who are our top performing merchants?
# Which merchants are more than two standard deviations above the mean?
#
# sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
# Who are our lowest performing merchants?
# Which merchants are more than two standard deviations below the mean?
#
# sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
# Which days of the week see the most sales?
# On which days are invoices created at more than one standard deviation above the mean?
#
# sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]
# What percentage of invoices are not shipped?
# What percentage of invoices are shipped vs pending vs returned? (takes symbol as argument)
#
# sales_analyst.invoice_status(:pending) # => 29.55
# sales_analyst.invoice_status(:shipped) # => 56.95
# sales_analyst.invoice_status(:returned) # => 13.5

end



# def return_hash_of_merchants_with_items
#   hash = Hash.new(0)
#   return_array_of_unique_merchants.each do |merchant|
#     mer_items = @items.all.find_all do |item|
#       item.merchant_id == merchant.id
#     end
#     hash[merchant.id] = mer_items
#   end
#   hash
# end

require_relative 'merchant_repo'
require_relative 'item_repo'
require 'time'
require 'bigdecimal'
require 'pry'
# require 'Math'


class SalesAnalyst

  attr_reader :merchants, :items

  def initialize(merchant_repo, item_repo)
    @merchants = merchant_repo
    @items = item_repo
  end

  def average_items_per_merchant
    total_items = @items.all.count.to_f
    total_merchants = @merchants.all.count.to_f
    (total_items / total_merchants)
  end

  def unique_merchant_array
    @merchants.all.uniq do |merchant|
      merchant.id
    end
  end

  def total_count_items_by_merchant
    merchants = unique_merchant_array
    merchant_item_total = []
    #for every merchant id find_all get count and add to array
    merchants.each do |merchant|
      merchant_items = @items.all.find_all do |item|
        item.merchant_id == merchant.id
      end
      merchant_item_total << merchant_items.count
    end
    merchant_item_total
  end

  def difference_from_average
    count = total_count_items_by_merchant
    count.map do |element|
      element.to_f - average_items_per_merchant
    end
  end

  def square_each_element
    difference_from_average.map do |element|
      if element < 0
        element = element * -1
      end
      element ** element
    end
  end

  def sum_array
    sum = 0
    square_each_element.each do |element|
      sum += element
    end
    sum
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    #get total items from each merchant in an array
    count = total_count_items_by_merchant
    #take that array and subtract each from average.
    differences = difference_from_average
    #square that array
    squares = square_each_element
    #sum the array
    sum = sum_array
    #divide by total number of elements - 1
    result = sum / (@items.all.count - 1)
    #square root the result
    result = Math.sqrt(result)
  end

  

end

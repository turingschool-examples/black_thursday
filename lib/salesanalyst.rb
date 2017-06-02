require 'pry'

class SalesAnalyst

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    a = item_count_per_merchant
    value = a.values
    sum = value.reduce(:+).to_f
    leng = value.length.to_f
    average = sum / leng
  end

  def average_items_per_merchant_standard_deviation
    a = item_count_per_merchant
    value = a.values
    standard_deviation(value)
  end

  def merchants_with_high_item_count
    counts = Hash.new(0)
    x = []
    y = []
    a = item_count_per_merchant
    a.each do |k,v|
      y << k if v > average_items_per_merchant_standard_deviation
    end
    return y
  end

  def retrieve_average_item_price_for_merchant(id)
    @parent.items.content.each do |k,v|
      if id == v.merchant_id
  end

private
  def standard_deviation(arr)
    mean = arr.reduce do |sum, element|
      sum + element
    end.to_f / arr.length
    variance = arr.reduce(0.0) do |sum, element|
      sum + (element - mean)**2
    end / (arr.length - 1)
    Math.sqrt(variance)
  end

  def item_count_per_merchant
    counts = Hash.new(0)
    x = []
    @parent.items.content.each do |k,v|
      x << v.merchant_id
    end
    x.each do |id|
      counts[id] += 1
    end
    return counts
  end
end

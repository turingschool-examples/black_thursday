require 'pry'

class SalesAnalyst
  attr_reader :ir,
              :mr
  def initialize(merchant_repository, item_repository)
      @mr = merchant_repository
      @ir = item_repository
  end

  def average_items_per_merchant
    sum = @ir.items_array.reduce(0) do |sum, item|
      sum + 1
    end
    (sum.to_f/@mr.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items = items_per_merchant
    individual_dev = items_per_merchant_deviation(merchant_items, average)
    each_squared = squared(individual_dev)
    standard_deviation(each_squared)
  end

  def items_per_merchant
    items_per_merchant = @ir.items_array.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant_deviation(items_per_merchant, average)
    items_per_merchant_deviation = items_per_merchant.map do | id, items |
      items.count - average
    end
  end

  def squared(items_per_merchant_deviation)
    squared = items_per_merchant_deviation.map do | deviation |
      deviation ** 2
    end
  end

  def standard_deviation(squared)
    squaresum = squared.reduce(0) do |sum, square|
      sum + square
    end
    (Math.sqrt(squaresum/(squared.length - 1))).round(2)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    merchants_hash = items_per_merchant.select do |id, items|
      (items.count - average) >= 3.26
    end
    @mr.merchants_array.find_all do |merchant|
      merchants_hash.include?(merchant.id)
    end
  end

end

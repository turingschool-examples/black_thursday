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
    items_per_merchant = ir.items_array.group_by do |item|
      item.merchant_id
    end

    items_per_merchant_deviation = items_per_merchant.map do | id, items |
      items.count - average
    end

    squared = items_per_merchant_deviation.map do | deviation |
      deviation ** 2
    end

    squaresum = squared.reduce(0) do |sum, square|
      sum + square
    end

    (Math.sqrt(squaresum/(squared.length - 1))).round(2)

  end

  def merchants_with_high_item_count


  end

end

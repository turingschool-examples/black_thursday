require_relative 'sales_engine'

class SalesAnalyst

  attr_reader   :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    total_items = se.items.all.count
    total_merchants = se.merchants.all.count
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def standard_deviation(numbers, average =average(numbers))
    num = numbers.map do |number|
      (number - average) ** 2
    end.sum
    Math.sqrt(num / (numbers.count - 1)).round(2)
  end

  def average(numbers)
    numbers.sum.to_f / numbers.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    
  end


end

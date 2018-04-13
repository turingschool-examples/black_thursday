# frozen_string_literal: true
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_items_per_merchant = all_items_per_merchant
    @number_of_items_per_merchant = @all_items_per_merchant.values.map {|value| value.count}
    binding.pry
  end

  def all_items_per_merchant
    @sales_engine.items.all.group_by{|item| item.merchant_id}
  end

  def average_items_per_merchant
    item_count = @all_items_per_merchant.values.map{|merch_items| merch_items.count}
    item_sum = find_sum(item_count)
    (item_sum.to_f / @all_items_per_merchant.values.count).round(2)
  end

  def find_sum(numbers)
    numbers.reduce(0){|sum, number| sum + number}.to_f
  end

  def find_mean(numbers)
    find_sum(numbers) / numbers.count
  end

  def find_standard_deviation(numbers)
    mean = find_mean(numbers)
    number_array = numbers.map {|numbers| mean - numbers}
    number_squared = number_array.map{|subtracted| subtracted ** 2}
    Math.sqrt(find_sum(number_squared) / (numbers.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    find_standard_deviation(@number_of_items_per_merchant)
  end

  


end

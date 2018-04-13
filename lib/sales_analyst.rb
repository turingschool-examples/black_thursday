# frozen_string_literal: true
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @all_items_per_merchant = all_items_per_merchant
    @number_of_items_per_merchant = @all_items_per_merchant.values.map {|value| value.count}
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
    numbers.inject(0){|sum, number| sum + number}.to_f
  end

  def find_mean(numbers)
    find_sum(numbers) / numbers.count
  end

  def standard_deviation
    
  end


  #subtract each number(array) from mean
  #take results and square each
  #find the sum of squared results
  #divide sum by (@number_of_items_per_merchant.count - 1)
  #find square root of result
  #rounded to two digits


  # def subtract_mean(numbers)
  #   numbers.map do |number|
  #     number - @average_items_per_merchant
  #   end
  # end

  def find_mean_of_new_numbers

    new_item_count = square_all_items_minus_mean.reduce(0){|sum, number| sum + number}
  end




  # def average_items_per_merchant_standard_deviation
  # end






end

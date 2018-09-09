require_relative '../lib/sales_analyst'

class SalesAnalyst

  def initialize(item_repo, merchant_repo)
    @item_repo = item_repo
    @merchant_repo = merchant_repo
  end

  def average_items_per_merchant
    (@item_repo.all.count.to_f / @merchant_repo.all.count).round(2)
  end

  def items_per_merchant_array
    @merchant_repo.all.map do |merchant|
      @item_repo.all.find_all do |item|
        merchant.id == item.merchant_id
      end.count
    end
  end

  def sum(array)
    array.inject(0) do |total, item|
      total += item
    end
  end

  def subtract_square_sum_array
    set = items_per_merchant_array
    average = average_items_per_merchant
    new_set = set.map do |element|
      (average - element)**2
    end
    sum(new_set)
  end

  def average_items_per_merchant_standard_deviation
    step_one = subtract_square_sum_array
    step_two = step_one/(@merchant_repo.all.count - 1)
    Math.sqrt(step_two).round(2)
  end

end

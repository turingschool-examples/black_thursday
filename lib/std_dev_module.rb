module StdDevModule

  def sum(array)
    type = 0 if array[0].class != BigDecimal
    type = BigDecimal.new(0,4) if array[0].class == BigDecimal
      array.inject(type) do |sum, price|
        price + sum
    end
  end

  def average_items_invoices_per_merchant(repo)
    (repo.all.count.to_f / @merchant_repo.all.count).round(2)
  end

  # Generate Needed Array
  def items_per_merchant_array(repo)
    @merchant_repo.all.map do |merchant|
      repo.all.find_all do |element|
        merchant.id == element.merchant_id
      end.count
    end
  end

  def subtract_square_sum_array_for_items_per_merchant(repo)
    set = items_per_merchant_array(repo)
    average = average_items_invoices_per_merchant(repo)
    new_set = set.map do |element|
      (average - element)**2
    end
    sum(new_set)
  end

  def per_merchant_standard_deviation(repo)
    step_one = subtract_square_sum_array_for_items_per_merchant(repo)
    step_two = step_one/(@merchant_repo.all.count - 1)
    Math.sqrt(step_two).round(2)
  end

  def standard_deviation(array)
    # Expect Array of numbers
    average = sum(array)/array.count
    total = sum(array.map do |number|
      (average - number)**2
    end)
    Math.sqrt(total/(array.length-1))
  end
end

# Take the difference between each number and the mean and square it
# Sum these square differences together
# Divide the sum by the number of elements minus 1
# Take the square root of this result

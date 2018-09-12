module StdDevModule

  def average_items_invoices_per_merchant(repo)
    (repo.all.count.to_f / @merchant_repo.all.count).round(2)
  end

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
end

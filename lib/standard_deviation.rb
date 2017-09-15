module StandardDeviation

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant

    difference_from_average = se.merchant_item_count.map do |item_count|
      item_count - average
    end
    squared_values = difference_from_average.map {|diff| diff ** 2}

    sum_of_squares = squared_values.sum

    Math.sqrt(sum_of_squares / (se.merchant_item_count.count - 1)).round(2)
  end

  def item_standard_deviation
    total_item_price = se.items.items.reduce(0) do |total_price, item|
      total_price + item.unit_price
    end
    average_item_price = total_item_price / se.total_items.to_f

    item_price_differences = se.items.items.map do |item|
      (item.unit_price - average_item_price) ** 2
    end

    sum_of_squares = item_price_differences.sum

    Math.sqrt(sum_of_squares / (se.total_items - 1))
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant.round

    difference_from_average = se.merchant_invoice_count.map do |invoice_count|
      invoice_count - average
    end
    squared_values = difference_from_average.map {|diff| diff ** 2}

    sum_of_squares = squared_values.sum

    std_dev = Math.sqrt(sum_of_squares / (se.merchant_invoice_count.count - 1))
  end

  def daily_invoice_standard_deviation
    average = average_invoices_per_day
    days = number_of_invoices_by_day
    #get the invoice count for the day and substract the average from it
    difference_from_average = days.map do |day, number|
      days[day] - average
    end
    squared_values = difference_from_average.map {|diff| diff ** 2}

    sum_of_squares = squared_values.sum

    Math.sqrt(sum_of_squares / 7).round(2)
  end
end

module StandardDeviation
  
  def sum(num_set)
    (num_set).inject(0){|accum, int| accum + int }
  end
  
  def mean(num_set)
    sum(num_set) / (num_set).length.to_f
  end

  def sample_variance(num_set)
    m = mean(num_set)
    sum = (num_set).inject(0){|accum, int| accum + (int - m) ** 2 }
    sum / ((num_set).length - 1).to_f
  end

  def standard_deviation(num_set)
    return Math.sqrt(sample_variance(num_set))
  end

  def item_number_plus_one_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def average_price_per_item_deviation
    items = sales_engine.items.all.map { |item| item.unit_price }
    format decimal standard_deviation(items).to_s
  end

  def two_standard_deviations_away_in_price
    average_average_price_per_merchant + (average_price_per_item_deviation*2)
  end

  def one_standard_deviation_above_invoice_average
    average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation*2)
  end

  def one_standard_deviation_below_invoice_average
    average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation*2)
  end
  
  def one_standard_deviation_above_mean_for_weekdays
    average(days_of_the_week.values) + standard_deviation(days_of_the_week.values)
  end
  
end

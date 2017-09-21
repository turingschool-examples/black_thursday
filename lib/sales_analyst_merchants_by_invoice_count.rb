module MerchantsByInvoiceCount

  def group_invoices_by_merchant
    merchant_ids = sales_engine.invoices.all.map do |invoice|
      invoice.merchant_id
     end
    invoice_counts = Hash.new 0
    merchant_ids.each do |merchant_id|
     invoice_counts[merchant_id] += 1.0
    end
    invoice_counts
  end

  def average_invoices_per_merchant
    sales_engine.invoices.all.count / sales_engine.merchants.all.count
  end

  def merchant_invoices_numerator
    numerator = 0
    group_invoices_by_merchant.each do |key, value|
     numerator += (value - average_invoices_per_merchant)**2
    end
    numerator
  end

  def merchant_invoices_denominator
    sales_engine.merchants.all.count - 1
  end

  def merchant_invoices_denominator_and_sqrt
    Math.sqrt((merchant_invoices_numerator) / merchant_invoices_denominator)
  end

  def standard_deviation_for_merchant_invoices
    merchant_invoices_denominator_and_sqrt
  end

  def two_standard_deviations_above_merchant_invoices
    average = average_invoices_per_merchant
    average + ((standard_deviation_for_merchant_invoices) * 2)
  end

  def two_standard_deviations_below_merchant_invoices
    average = average_invoices_per_merchant
    average - ((standard_deviation_for_merchant_invoices) * 2)
  end
end

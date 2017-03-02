module MerchantInvoiceAnalyst

  def average_invoices_per_merchant
    average(invoice_set)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_set)
  end

  def top_merchants_by_invoice_count
    top_threshold_invoices ||= top_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count > top_threshold_invoices
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_threshold_invoices ||= bottom_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count < bottom_threshold_invoices
    end
  end

  def merchants_with_pending_invoices
    merchants_pending ||= merchants.select do |merchant|
      merchant.any_pending?
    end
  end

  private

  def merchants
    engine.merchants.all
  end

end
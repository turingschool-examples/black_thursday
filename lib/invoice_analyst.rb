module InvoiceAnalyst

  def average_invoices_per_merchant
    find_mean(invoices_for_merchants.map { |merch, invs| invs.count }).round(2)
  end

  def invoices_for_merchants
    @invoices.all.group_by { |invoice| invoice.merchant_id }
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_for_merchants.map { |merch, invs| invs.count}).to_f.round(2)
  end

  def ave_invoices_per_day
    @invoices.all.count / 7
  end

  def std_dev_inv_per_day
    number_set = invoices_by_day.map do |day, invoices|
      invoices.count
    end
    standard_deviation(number_set)
  end

  def invoices_by_day
    @invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%w")
    end
  end

  def invoice_status(status)
    invoices_w_status = @invoices.all.count { |invoice| invoice.status == status }
    (invoices_w_status / @invoices.all.count.to_f * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    return false if @transactions.find_all_by_invoice_id(invoice_id) == []
    @transactions.find_all_by_invoice_id(invoice_id).all? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_total_by_item = @invoice_items.find_all_by_invoice_id(invoice_id).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    sum(invoice_total_by_item)
  end

  def top_days_by_invoice_count
    top_days = invoices_by_day.find_all do |day, invoices|
      invoices.count > ave_invoices_per_day + std_dev_inv_per_day
    end
    top_days.map! { |day, invoices| day }
    convert_to_day_names(top_days)
  end

end

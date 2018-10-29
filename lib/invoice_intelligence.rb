module InvoiceIntelligence
  def invoice_status(status)
    invoice_count = @invoices.all.count
    status_sum = @invoices.all.reduce(0) do |sum, invoice|
      sum += 1 if invoice.status == status
      sum
    end
    (status_sum.to_f / invoice_count * 100).round(2)
  end

  def top_days_by_invoice_count
    temp_days_with_count = days_with_count
    av = average(*temp_days_with_count.values)
    temp_sd = standard_deviation(*temp_days_with_count.values)
    temp_days_with_count.select{|day,count| count > av + temp_sd}.keys
  end

  def each_invoice_day
    @invoices.all.map{|iv| iv.created_at.strftime("%A")}
  end

  def invoice_has_no_transactions?(invoice_id)
    @transactions.find_all_by_invoice_id(invoice_id).length == 0
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions == []
    paid_in_full = true
    transactions.each do |transaction|
      paid_in_full = false unless transaction.result == :success
    end
    paid_in_full
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)
    sum_invoice_items_revenue(invoice_items)
  end

  def sum_invoice_items_revenue(invoice_items)
    invoice_items.reduce(0) do |sum, invoice_item|
      sum += invoice_item.revenue
      sum
    end
  end

  def get_total_from_all_invoice_items_for(invoice_id)
    matching_invoice_items = invoice_items.find_all_by_invoice_id(invoice_id)
    sum_invoice_items_revenue(matching_invoice_items)
  end

  def at_least_one_succesful_transaction?(invoice_id)
    transactions_for_invoice = transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions_for_invoice.length == 0
    transactions_for_invoice.find {|transaction| transaction.result == :success}
  end

  def all_transactions_successful_for?(invoice_id)
    transactions_for_invoice = transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions_for_invoice.length == 0
    transactions_for_invoice.reduce(true) do|all_success, transaction|
      all_success = false if transaction.result != :success
      all_success
    end
  end

  def get_item_count_for(invoice_id)
    all_items = invoice_items.find_all_by_invoice_id(invoice_id)
    all_items.reduce(0) do |item_count, invoice_item|
      item_count += invoice_item.quantity
      item_count
    end
  end

  def best_invoice_by_quantity
    successful_invoices.max_by{|invoice| quantity_of_invoice(invoice)}
  end
  def best_invoice_by_revenue
    successful_invoices.max_by{|invoice| revenue_from_invoice(invoice)}
  end

  def quantity_of_invoice(invoice)
    find_from_invoice(invoice, 'InvoiceItem').reduce(0) do |sum, invoice_item|
      sum += invoice_item.quantity
    end
  end

  def successful_invoices
    @invoices.all.select do |invoice|
      @transactions.any_success?(invoice.id)
    end
  end

  def unsuccessful_invoices
    @invoices.all - successful_invoices
  end
end

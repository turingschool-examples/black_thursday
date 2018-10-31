module InvoiceIntelligence
  def invoice_status(status)
    status_sum = @invoices.all.count { |invoice| invoice.status == status }
    (status_sum.to_f / @invoices.all.count * 100).round(2)
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
    transactions.all? { |tr| tr.result == :success }
  end

  def invoice_total(invoice_id)
    sum_invoice_items_revenue(@invoice_items.find_all_by_invoice_id(invoice_id))
  end

  def sum_invoice_items_revenue(invoice_items)
    sum(*invoice_items) { |invoice_item| invoice_item.revenue }
  end

  def all_transactions_successful_for?(invoice_id)
    transactions_for_invoice = transactions.find_all_by_invoice_id(invoice_id)
    return false if transactions_for_invoice.length == 0
    transactions_for_invoice.all? { |tr| tr.result == :success }
  end

  def get_item_count_for(invoice_id)
    all_items = invoice_items.find_all_by_invoice_id(invoice_id)
    sum(*all_items) { |invoice_item| invoice_item.quantity }
  end

  def best_invoice_by_quantity
    successful_invoices.max_by{|invoice| quantity_of_invoice(invoice)}
  end

  def best_invoice_by_revenue
    successful_invoices.max_by{|invoice| revenue_from_invoice(invoice)}
  end

  def quantity_of_invoice(invoice)
    sum(*find_from_invoice(invoice, 'InvoiceItem')) {|iitem| iitem.quantity}
  end

  def successful_invoices
    @invoices.all.select do |invoice|
      @transactions.any_success?(invoice.id)
    end
  end

  def revenue_from_invoice(invoice)
    invoice_total(invoice.id)
  end

  def revenue_from_invoices(invoices)
    amounts = invoices.reduce([]) do |arr, invoice|
      arr << revenue_from_invoice(invoice)
    end
    result = amounts.reduce(&:+)
    result ? result : 0
  end

  def unsuccessful_invoices
    @invoices.all - successful_invoices
  end
end

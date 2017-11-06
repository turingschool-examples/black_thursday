module CustomerAnalyst
  def top_buyers(x = 20)
    #think about other ways to make connections
    customer_spend = customer_spend(all_customer_invoices)
    sorted = sorted_customer_spend(customer_spend)
    sorted.take(x).map do |(customer_id, spend)|
      se.find_customer_by_id(customer_id)
    end
  end

  def top_merchant_for_customer(customer_id)
    customer_invoices = se.invoices.find_all_by_customer_id(customer_id)
    merchant_totals = customer_total_spend_per_merchant(customer_invoices)
    merchant = merchant_totals.max_by {|(merchant, total_spend)| total_spend}[0]
    se.merchants.find_by_id(merchant)
  end

  # def one_time_buyers
  #   all_customer_invoices.each do (|customer, )
  #
  # end

  private
  def customer_total_spend_per_merchant(customer_invoices)
    customer_invoices.reduce({}) do |result, invoice|
      result[invoice.merchant_id] = 0 if !result[invoice.merchant_id]
      result[invoice.merchant_id] += invoice.total
      result
    end
  end

  def all_customer_invoices
    se.invoices.all.reduce({}) do |result, invoice|
      result[invoice.customer_id] = [] if !result.include?(invoice.customer_id)
      result[invoice.customer_id] << invoice.id
      result
    end
  end

  def customer_spend(all_customer_invoices, index = 0, result = {})
    return {} if index == se.customers.all.length
    result = customer_spend(all_customer_invoices, (index + 1), result)
    if !all_customer_invoices[index].nil?
      result[index] = customer_total(all_customer_invoices[index])
    end
    return result
  end

  def customer_total(invoice_ids)
    invoice_ids.map do |invoice_id|
      invoice = se.find_invoice_by_invoice_id(invoice_id)
      invoice.total
    end.sum
  end

  def sorted_customer_spend(customer_spend)
    customer_spend.sort_by do |(customer_id, spend)|
      (-1) * spend
    end
  end
end

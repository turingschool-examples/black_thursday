module CustomerAnalyst
  def top_buyers(x = 20)
    # customer_invoices
    customer_spend = customer_spend(customer_invoices)
    sorted = sorted_customer_spend(customer_spend)
    sorted.take(x).map do |(customer_id, spend)|
      se.find_customer_by_id(customer_id)
    end
  end

  def customer_invoices
    se.invoices.all.reduce({}) do |result, invoice|
      result[invoice.customer_id] = [] if !result.include?(invoice.customer_id)
      result[invoice.customer_id] << invoice.id
      result
    end
  end

  def customer_spend(customer_invoices, index = 0)
    return {} if index == se.customers.all.length
    result = {}
    result = customer_spend(customer_invoices, (index + 1))
    if !customer_invoices[index].nil?
      result[index] = customer_total(customer_invoices[index])
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

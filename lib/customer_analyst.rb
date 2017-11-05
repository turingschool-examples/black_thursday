module CustomerAnalyst
  def top_buyers(x = 20)
    customer_invoices = se.invoices.all.reduce({}) do |result, invoice|
      result[invoice.customer_id] = [] if !result.include?(invoice.customer_id)
      result[invoice.customer_id] << invoice.id
      result
    end
    customer_spend = customer_invoices.reduce({}) do |result, (customer_id, invoice_ids)|
      result[customer_id] = 0
      invoice_ids.map do |invoice_id|
        invoice = se.find_invoice_by_invoice_id(invoice_id)
        result[customer_id] += invoice.total
      end
      result
    end
    sorted = customer_spend.sort_by do |(customer_id, spend)|
      (-1) * spend
    end
    top_x_customers = sorted.take(x)
    top_x_customers.map do |(customer_id, spend)|
      se.find_customer_by_id(customer_id)
    end
  end


end

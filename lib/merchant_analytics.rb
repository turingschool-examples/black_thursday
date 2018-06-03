module MerchantAnalytics

  def total_revenue_by_date(date)
    revenues_by_date = paid_invoices_by_date(date).map do |invoice|
      invoice_total(invoice.id)
    end
    sum(revenues_by_date)
  end

  def paid_invoices_by_date(date)
    @sales_engine.invoices.all.map do |invoice|
      if invoice_paid_in_full?(invoice.id) && invoice.created_at == date
        invoice
      end
    end.compact
  end

  def top_revenue_earners(amount_of_merchants = 20)
    merchants_ranked_by_revenue[0..amount_of_merchants-1]
  end

  def merchant_revenue_table
    @sales_engine.merchants.all.map do |merchant|
      [merchant.id, BigDecimal(sum(total_revenue_by_merchant(merchant.id)))]
    end.to_h
  end

  def total_revenue_by_merchant(merchant_id)
    single_merchants_invoices(merchant_id).map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice_total(invoice.id)
      end
    end.compact
  end

  def merchants_ranked_by_revenue
    sorted_list = merchant_revenue_table.sort_by{|merchant_id, revenue| revenue}.reverse
    # binding.pry
    sorted_list.map do |pair|
      @sales_engine.merchants.find_by_id(pair[0])
    end
  end
end

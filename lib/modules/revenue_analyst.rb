module RevenueAnalyst
  def total_revenue_by_date(date)
    date = date.to_s.split(" ")[0]
    arr  = invoices.select {|item| item.created_at.to_s.split(" ")[0] == date}
    arr.map(&:total).sum
  end

  def top_revenue_earners(x = 20)
    merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse.shift(x)
  end

  def revenue_by_merchant(id)
    invoices = engine.merchants.find_invoices_by_merchant_id(id)
    invoices.reduce(0) {|sum, invoice| sum += invoice.total}
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.length)
  end
end
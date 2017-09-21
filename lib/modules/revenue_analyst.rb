module RevenueAnalyst
  def self.total_revenue_by_date(date, invoices)
    date = date.to_s.split(" ")[0]
    arr  = invoices.select {|item| item.created_at.to_s.split(" ")[0] == date}
    arr.map(&:total).sum
  end

  def self.top_revenue_earners(merchants, engine, x)
    merchants.sort_by do |merchant|
      revenue_by_merchant(merchant.id, engine)
    end.reverse.shift(x)
  end

  def self.revenue_by_merchant(id, engine)
    invoices = engine.merchants.find_invoices_by_merchant_id(id)
    invoices.reduce(0) {|sum, invoice| sum += invoice.total}
  end
end
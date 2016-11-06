module AnalysisSetup

  def average(collection)
    collection.reduce(&:+).to_f / collection.size.to_f
  end

  def decimal(number)
    BigDecimal.new(number)
  end

  def format(number)
    number.round(2).to_f
  end

  def invoice_counts
    sales_engine.merchants.all.map { |merchant| merchant.invoices.size }
  end

  def item_counts
    sales_engine.merchants.all.map { |merchant| merchant.items.size }
  end

  def price_counts(id)
    sales_engine.merchants.find_all_items_by_merchant(id).map do |item|
      item.unit_price
    end
  end

  def status_average_operator(status)
    matches = sales_engine.invoices.all.find_all do |invoice| 
      invoice.id if invoice.status.eql?(status)
    end
    ((matches.size.to_f / sales_engine.invoices.all.size.to_f) * 100).to_s
  end

  def price_average_operator(id)
    decimal(average(price_counts(id)).to_s).round(2)
  end

  def average_average_operator
    averages = sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    decimal(average(averages).to_s).round(2)
  end

end


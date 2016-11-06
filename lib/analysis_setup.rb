module AnalysisSetup

  def status_average_operator(matches)
    ((matches.size.to_f / sales_engine.invoices.all.size.to_f) * 100).to_s
  end

  def average(collection)
    collection.reduce(&:+).to_f / collection.size.to_f
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

end


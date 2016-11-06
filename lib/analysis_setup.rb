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

  def item_number_plus_one_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def all_merchants_high_items_count
    merchants = []
    sales_engine.merchants.all.map do |merchant|
      if merchant.items.count >= item_number_plus_one_deviation
        merchants << merchant
      end
    end
    merchants
  end

  def average_price_per_item_deviation
    items = []
    sales_engine.items.all.map do |item|
      items << item.unit_price
    end
    format decimal standard_deviation(items).to_s
  end


  def two_standard_deviations_away_in_price
    average_average_price_per_merchant + (average_price_per_item_deviation*2)
  end

  def all_golden_items_for_merchants
    items = []
    sales_engine.merchants.all.map do |merchant|
      merchant.items.each do |item|
        if item.unit_price >= two_standard_deviations_away_in_price
          items << item
        end
      end
    end
    items
  end

end


class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def total_merchants
    merchants = @se.merchants.map do |merchant|
      merchant.name
    end.sum
  end

  def total_items
    items = @se.items.map do |item|
      item.merchant_id
    end.sum
  end

  def average_items_per_merchant
    total_items / total_merchants
  end

end

class SalesAnalyst

  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchant_repo = sales_engine.merchants
    @item_repo = sales_engine.items
    @invoice_repo = sales_engine.invoices
  end

  def average_items_per_merchant
    total_merchants = merchant_repo.all.count
    total_items = item_repo.all.count
    total_items.to_f / total_merchants
  end

  def standard_deviation_in_items_per_merchant
    average = average_items_per_merchant
    deviation = sum_deviation(average)
    denominator = merchant_repo.all.count - 1
    Math.sqrt(deviation / denominator)
  end

  def sum_deviation(average)
    merchant_repo.all.reduce(0) do |deviation, merchant|
      (merchant.items.count - average) ** 2
    end
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_deviation = standard_deviation_in_items_per_merchant
    merchant_repo.all.select do |merchant|
      merchant.items.count > (standard_deviation + average)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_unit_price = items.reduce(0) do |total, item|
      total += item.unit_price
    end
    item_unit_price / items.count
  end

  def average_average_price_per_merchant
    sum = merchant_repo.all.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    sum / merchant_repo.all.count
  end

  def golden_items
      average = average_item_price
      deviation = standard_deviation_in_items_price(average)
      item_repo.all.select do |item|
        item.unit_price > average + deviation * 2
      end
  end

  def average_item_price
    sum = item_repo.all.reduce(0) do |total, item|
      total += item.unit_price
    end
    sum / item_repo.all.count
  end

  def standard_deviation_in_items_price(average)
    deviation = item_repo.all.reduce(0) do |total, item|
      total += (item.unit_price - average) ** 2
    end
    item_count = item_repo.all.count
    Math.sqrt(deviation / (item_count - 1))
  end

  def average_invoices_per_merchant
    invoice_count = invoice_repo.all.count
    merchant_count= merchant_repo.all.count
    invoice_count.to_f / merchant_count
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    deviation  = standard_deviation_in_invoices(average)
    merchants = merchant_repo.all.count
    Math.sqrt(deviation/(merchants - 1))
  end

  def standard_deviation_in_invoices(average)
    merchant_repo.all.reduce(0) do |total, merchant|
      total += (merchant.invoices.count - average) ** 2
    end
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    result = merchant_repo.all.select do |merchant|
      merchant.invoices.count > average + standard_deviation * 2
    end
    return result || []
  end

  def bottom_merchants_by_invoice_count
  end

  def top_days_by_invoice_count
  end

  def invoice_status(status)
  end
end

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
  #items per merchant
  def average_items_per_merchant
    total_merchants = merchant_repo.all.count
    total_items = item_repo.all.count
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    deviation = sum_deviation(average)
    denominator = merchant_repo.all.count - 1
    Math.sqrt(deviation / denominator).round(2)
  end

  def sum_deviation(average)
    merchant_repo.all.reduce(0) do |deviation, merchant|
      deviation += (merchant.items.count - average) ** 2
    end
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    merchant_repo.all.select do |merchant|
      merchant.items.count > (standard_deviation + average)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_unit_price = items.reduce(0) do |total, item|
      total += item.unit_price
    end
    (item_unit_price / items.count).round(2)
  end

  def average_average_price_per_merchant
    sum = merchant_repo.all.reduce(0) do |total, merchant|
      total += average_item_price_for_merchant(merchant.id)
    end
    (sum / merchant_repo.all.count).floor(2)
  end

  #items
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

  #invoices per merchant
  def average_invoices_per_merchant
    invoice_count = invoice_repo.all.count
    merchant_count= merchant_repo.all.count
    (invoice_count.to_f / merchant_count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    deviation  = standard_deviation_in_invoices(average)
    merchants = merchant_repo.all.count
    Math.sqrt(deviation/(merchants - 1)).round(2)
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
      merchant.invoices.count > (average + (standard_deviation * 2))
    end
    return result || []
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    result = merchant_repo.all.select do |merchant|
      merchant.invoices.count <= (average - (standard_deviation * 2))
    end
    result || []
  end

  #invoices by day
  def average_invoices_per_day
    invoice_repo.all.count / 7
  end

  def group_invoices_by_day
    invoice_repo.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    deviation = deviation_in_invoices_per_day(average)
    Math.sqrt(deviation / 6).round(2)
  end

  def deviation_in_invoices_per_day(average)
    invoices_on_days = group_invoices_by_day
    sum = invoices_on_days.values.reduce(0) do |total, invoices_on_day|
      total += (invoices_on_day.count - average) ** 2
    end
    sum
  end
  def top_days_by_invoice_count
    average = average_invoices_per_day
    standard_deviation = average_invoices_per_day_standard_deviation
    invoices_by_days = group_invoices_by_day
    invoices_by_days.keys.select do |day|
      invoices_by_days[day].count > average + standard_deviation
    end
  end
  def invoice_status(status)
    # binding.pry
    invoice_count = invoice_repo.all.count
    invoices_with_status = invoice_repo.find_all_by_status(status).count
    (invoices_with_status.to_f / invoice_count * 100.0).round(2)
  end
end

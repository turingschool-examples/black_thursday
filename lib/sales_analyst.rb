class SalesAnalyst
  include Math

  def initialize(engine)
    @engine = engine
  end

  def items_per_merchant
    @count = 0
    @engine.all_merchants.map do |merchant|
      @count += 1
      @engine.find_all_items_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    (items_per_merchant.sum / @engine.all_merchants.count.to_f).round(2)
  end

  def merchants_with_high_item_count
    aipmsd = average_items_per_merchant_standard_deviation
    aipm = average_items_per_merchant
    @engine.all_merchants.find_all do |merchant|
      @engine.find_all_items_by_merchant_id(merchant.id).count >
      (aipm + aipmsd)
    end
  end

  def average_item_price_for_merchant(id)
    prices = @engine.find_all_items_by_merchant_id(id).map do |item|
      item.unit_price
    end
    (prices.sum / prices.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    aipm = average_items_per_merchant
    standard = items_per_merchant.map do |number|
      (number - aipm) ** 2
    end.sum
    Math.sqrt(standard / (@count - 1)).round(2)
  end

  def average_average_price_per_merchant
    avg = @engine.all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (avg.sum / avg.count).round(2)
  end

  def average_price
    @item_count = 0
    @prices = @engine.all_items.map do |item|
      @item_count += 1
      item.unit_price
    end
    (@prices.sum / @prices.count).round(2)
  end

  def average_price_standard_deviation
    ap = average_price
    standard = @prices.map do |number|
      (number - ap) ** 2
    end
    standard_sum = standard.sum
    Math.sqrt(standard_sum / (@item_count - 1)).round(2)
  end

  def golden_items
    ap = average_price
    apsd = average_price_standard_deviation
    @engine.all_items.find_all do |item|
      item.unit_price > (ap + (apsd * 2))
    end
  end

  def invoices_per_merchant
    @count_inv = 0
    @engine.all_merchants.map do |merchant|
      @count_inv += 1
      @engine.find_all_invoices_by_merchant_id(merchant.id).count
    end
  end

  def average_invoices_per_merchant
    (invoices_per_merchant.sum / @engine.all_merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    aipm = average_invoices_per_merchant
    standard = invoices_per_merchant.map do |number|
      (number - aipm) ** 2
    end.sum
    Math.sqrt(standard / (@count_inv - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    @engine.all_merchants.find_all do |merchant|
      @engine.find_all_invoices_by_merchant_id(merchant.id).count > (aipm + (aipmsd * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    aipm = average_invoices_per_merchant
    aipmsd = average_invoices_per_merchant_standard_deviation
    @engine.all_merchants.find_all do |merchant|
      @engine.find_all_invoices_by_merchant_id(merchant.id).count < (aipm - (aipmsd * 2))
    end
  end

  def invoices_per_day
    @engine.all_invoices.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
  end

  def average_invoices_per_day
    count = invoices_per_day.map do |key, value|
      value.count
    end
    count.sum / 7
  end

  def average_invoices_per_day_standard_deviation
    aipd = average_invoices_per_day
    standard = invoices_per_day.map do |key, value|
      (value.count - aipd) ** 2
    end.sum
    Math.sqrt(standard / 6).round(2)
  end

  def top_days_by_invoice_count
    aipd = average_invoices_per_day
    aipdsd = average_invoices_per_day_standard_deviation
    array = invoices_per_day.find_all do |key, value|
      value.count > (aipd + aipdsd)
    end
    array.map do |day|
      day[0]
    end
  end

  def invoice_status(status)
    status_count = @engine.all_invoices.find_all do |invoice|
      (invoice.status == status)
    end
    ((status_count.count / @engine.all_invoices.count.to_f) * 100).round(2)
  end
end

class SalesAnalyst
  attr_reader :merchants, :items, :se, :invoices, :invoice_items

  def initialize(se)
    @se = se
    @merchants = se.merchants
    @items = se.items
    @invoices = se.invoices
    @invoice_items =
    se.invoice_items
  end

  def items_per_merchant
    merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def average_items_per_merchant
    (items_per_merchant.reduce(:+)/items_per_merchant.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant
    av = average_items_per_merchant
    sqdiff = ipm.map do |num|
      (num - av) ** 2
    end
    Math.sqrt(sqdiff.reduce(:+) / (ipm.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    ave_std_dev = average_items_per_merchant_standard_deviation + average_items_per_merchant
    merchants_with_item_counts.map do |merchant|
      merchant[1] > ave_std_dev ? merchant[0] : []
    end.flatten
  end

  def merchants_with_item_counts
    merchants.all.map do |merchant|
      [merchant, merchant.items.count]
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = merchants.find_by_id(merchant_id).items
    rounding = merchant_items.reduce(0) do |sum, item|
      sum + item.unit_price
    end / merchant_items.length
    rounding.round(2)
  end

  def average_average_price_per_merchant
    rounding = merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end / merchants.all.length
    rounding.round(2)
  end

  def all_items_unit_prices
    items.all.map do |item|
      item.unit_price
    end
  end

  def average_items_price
    all_items_unit_prices.reduce(:+)/all_items_unit_prices.length
  end

  def items_price_standard_deviation
    all = all_items_unit_prices
    av = average_items_price
    sqdiff = all.map do |num|
      (num - av) ** 2
    end
    Math.sqrt(sqdiff.reduce(:+) / (all.length - 1)).round(2)
  end

  def golden_items
    isd = items_price_standard_deviation
    items.all.find_all do |item|
      item.unit_price > isd * 2
    end
  end

  def invoices_per_merchant
    merchants.all.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant
    (invoices_per_merchant.reduce(:+)/invoices_per_merchant.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    ipm = invoices_per_merchant
    av = average_invoices_per_merchant
    sqdiff = ipm.map {|num| (num - av) ** 2}
    Math.sqrt(sqdiff.reduce(:+) / (ipm.length - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    av = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation
    merchants.all.find_all do |merchant|
      merchant.invoices.count > (av + (sd * 2))
    end
  end

  def bottom_merchants_by_invoice_count
    av = average_invoices_per_merchant
    sd = average_invoices_per_merchant_standard_deviation
    merchants.all.find_all do |merchant|
      merchant.invoices.count < (av - (sd * 2))
    end
  end

  def days_with_invoices
    invoices.all.group_by do |invoice|
    invoice.created_at.strftime("%A")
    end
  end

  def days_with_count
    days_with_invoices.map do |key, value|
    { key => value.length }
    end
  end

  def invoices_by_day
    days_with_count.map do |hash|
      hash.values
    end.flatten
  end

  def invoices_by_day_average
    invoices_by_day.reduce(:+) / invoices_by_day.length
  end

  def standard_deviation(elements, average)
    sqdiff = elements.map {|num| (num - average) ** 2}
    Math.sqrt(sqdiff.reduce(:+) / (elements.length - 1)).round(2)
  end

  def top_days_by_invoice_count
    top_days = []
    days_with_count.each do |hash|
      hash.each do |key, value|
        if value > (invoices_by_day_average + standard_deviation(invoices_by_day, invoices_by_day_average))
        top_days << key
        end
      end
    end
    top_days
  end

  def invoice_status(status)
    total = invoices.all.count {|invoice| invoice}
    is = invoices.all.count do |invoice|
      invoice.status == status
    end
  ((is / total.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    ii = []
    invoice_items.all.each do |invoice_item|
      if invoice_item.created_at <= Time.parse(date)
      ii << invoice_item.unit_price
      end
    end
    ii.reduce(:+)
  end

  def top_revenue_earners(x=20)
    tr = merchants.all.each do |merchant|
      merchant.invoices.each do |invoice|
        invoice.total
      end
    end
    tr.take(x)
  end

  def merchants_with_pending_invoices
    merchants.all.select do |merchant|
      merchant.invoices.each do |invoice|
        invoice.transactions.none? { |transaction| transaction.result == "success" }
      end
    end
  end

end

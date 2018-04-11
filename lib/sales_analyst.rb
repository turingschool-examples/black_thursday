# Sales Analyst class for analyzing data
class SalesAnalyst
  attr_reader :engine
  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    merch_count = @engine.merchants.all.count
    item_count = @engine.items.all.count
    (BigDecimal(item_count) / BigDecimal(merch_count)).round(2).to_f
  end

  def items_per_merchant
    items_by_merch = @engine.items.all.group_by(&:merchant_id)

    items_by_merch.each_key do |key|
      items_by_merch[key] = items_by_merch[key].length
    end
  end

  def average_items_per_merchant_standard_deviation
    ipm = items_per_merchant.values.sort
    array = ipm.map do |items_per_merch|
      (items_per_merch - average_items_per_merchant)**2
    end

    variance = array.inject(0) do |sum, num|
      sum + num
    end

    std_dev = variance / (array.count - 1)
    Math.sqrt(std_dev).to_f.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg = average_items_per_merchant
    items_per_merchant.map do |id, num_of_items|
      @engine.merchants.find_by_id(id) if num_of_items >= avg + std_dev
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    total = items_per_merchant[merchant_id]
    items_by_merch = @engine.items.all.group_by(&:merchant_id)
    sum_of_prices = items_by_merch[merchant_id].inject(0) do |sum, item|
      sum + item.unit_price
    end
    (sum_of_prices / total).round(2)
  end

  def average_average_price_per_merchant
    all_merchants = @engine.merchants.all
    all_averages = all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (all_averages.inject(:+) / all_averages.count).round(2)
  end

  def average_item_price
    total_items = @engine.items.all.count
    all_item_prices = @engine.items.all.map(&:unit_price)
    all_item_prices.inject(:+) / total_items
  end

  def average_item_price_standard_deviation
    array = @engine.items.items.values.map(&:unit_price).sort
    variance = array.inject(0) do |sum, price|
      sum + ((price - average_item_price)**2)
    end
    std_dev = variance / (array.count - 1)
    Math.sqrt(std_dev).to_f.round(2)
  end

  def golden_items
    items = @engine.items.all
    deviation = average_item_price + (average_item_price_standard_deviation * 2)
    items.map do |item|
      item if item.unit_price >= deviation
    end.compact
  end

  def average_invoices_per_merchant
    (BigDecimal(@engine.invoices.all.count) / BigDecimal(@engine.merchants.all.count)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    # Get a set
    all_merchants = @engine.invoices.all.map(&:merchant_id).uniq
    number_of_invoices_per_merchant = all_merchants.map do |merchant_id|
      invoice_count(merchant_id)
    end
    # Sum all number in that set - average, squared
    deviate_sum = number_of_invoices_per_merchant.inject(0) do |sum, number_of_invoices|
      sum + ((number_of_invoices - average_invoices_per_merchant) ** 2)
    end
    # Divide that sum by two
    # Get the sqrt of that quotient
    Math.sqrt(deviate_sum / 2).round(2)
  end

  def invoice_count(merchant_id)
    @engine.invoices.find_all_by_merchant_id(merchant_id).count
  end

  def top_merchant_by_invoice_count
    invoices_per_merchant = {}
    @engine.invoices.all.each do |invoice|
      invoices_per_merchant[invoice.merchant_id] = invoice_count(invoice.merchant_id)
    end
    top = invoices_per_merchant.map do |id, count|
      require 'pry';binding.pry
      @engine.merchants.find_by_id(id) if count >= average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    end
  end

end

require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
    set_repo_variables
    set_all_item_variables
    set_relational_variables
    set_item_math_result_variables
    set_invoice_math_result_variables
  end

  def set_repo_variables
    @merchant_repo         = sales_engine.merchants
    @item_repo             = sales_engine.items
    @invoice_repo          = sales_engine.invoices
  end

  def set_all_item_variables
    @merchants             = @merchant_repo.all
    @items                 = @item_repo.all
    @invoices              = @invoice_repo.all
  end

  def set_relational_variables
    @items_per_merchant    = items_per_merchant
    @invoices_per_merchant = invoices_per_merchant
  end

  def set_item_math_result_variables
    @avg_items_per_merchant = average_items_per_merchant
    @avg_items_per_merch_stdev = average_items_per_merchant_standard_deviation
    @item_unit_prices = item_unit_prices
    @avg_item_price = average_item_price
    @item_price_stdev = item_price_standard_deviation
  end

  def set_invoice_math_result_variables
    @avg_invoices_per_merchant = average_invoices_per_merchant
    @avg_inv_per_merch_stdev = average_invoices_per_merchant_standard_deviation
    @day_invoice_created = day_invoice_created
    @days_of_week_invoice_count = days_of_week_invoice_count
    @avg_invoices_per_day = average_invoices_per_day
    @invoices_per_day_stdev = invoices_per_day_standard_deviation
  end

  def items_per_merchant
    @merchants.map do |merchant|
      merchant.items.count
    end
  end

  def invoices_per_merchant
    @merchants.map do |merchant|
      @invoice_repo.find_all_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    count = @merchants.count
    average = @items_per_merchant.inject { |sum, num| sum + num }.to_f / count
    average.round(2)
  end

  def average_items_per_merchant_standard_deviation
    dif = @items_per_merchant.map { |num| (num - @avg_items_per_merchant)**2 }
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (@items_per_merchant.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    zipped = @items_per_merchant.zip(@merchants)
    average = @avg_items_per_merchant
    stdev = @avg_items_per_merch_stdev
    found = zipped.find_all { |merchant| merchant[0] > (average + stdev) }
    found.map { |merchant| merchant[1] }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchant_repo.find_by_id(merchant_id)
    prices = merchant.items.map(&:unit_price)
    count = prices.count
    item_average_price = prices.inject { |sum, num| sum + num }.to_f / count
    BigDecimal.new item_average_price, 4
  end

  def find_average_price(merchant)
    if merchant.items.empty?
      0
    else
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    prices = @merchants.map do |merchant|
      find_average_price(merchant)
    end
    count = prices.count
    average_average_price = prices.inject { |sum, num| sum + num }.to_f / count
    BigDecimal.new(average_average_price, 0).truncate 2
  end

  def item_unit_prices
    @items.map(&:unit_price)
  end

  def average_item_price
    count = @item_unit_prices.count
    @item_unit_prices.inject { |sum, num| sum + num }.to_f / count.round(2)
  end

  def item_price_standard_deviation
    dif = @item_unit_prices.map { |num| (num - @avg_item_price)**2 }
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (@item_unit_prices.count - 1)).round(2)
  end

  def golden_items
    zipped = @item_unit_prices.zip(@items)
    average = @avg_item_price
    stdev = @item_price_stdev
    found = zipped.find_all { |item| item[0] > (average + (stdev * 2)) }
    found.map { |item| item[1] }
  end

  def average_invoices_per_merchant
    count = @invoices_per_merchant.count
    avg = @invoices_per_merchant.inject { |sum, num| sum + num }.to_f / count
    avg.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    dif = @invoices_per_merchant.map do |num|
      (num - @avg_invoices_per_merchant)**2
    end
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (@invoices_per_merchant.count - 1)).round 2
  end

  def top_merchants_by_invoice_count
    zipped = @invoices_per_merchant.zip(@merchants)
    average = @avg_invoices_per_merchant
    stdev = @avg_inv_per_merch_stdev
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def bottom_merchants_by_invoice_count
    zipped = @invoices_per_merchant.zip(@merchants)
    average = @avg_invoices_per_merchant
    stdev = @avg_inv_per_merch_stdev
    found = zipped.find_all { |invoice| invoice[0] < (average - (stdev * 2)) }
    found.map { |invoice| invoice[1] }
  end

  def day_invoice_created
    @invoices.map { |invoice| invoice.created_at.strftime('%A') }
  end

  def days_of_week_invoice_count
    @days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    @days.map { |day| @day_invoice_created.count(day) }
  end

  def average_invoices_per_day
    count = @days_of_week_invoice_count.count
    average = @days_of_week_invoice_count.inject do |sum, num|
      sum + num
    end.to_f / count
    average.round(2)
  end

  def invoices_per_day_standard_deviation
    dif = @days_of_week_invoice_count.map do |num|
      (num - @avg_invoices_per_day)**2
    end
    added = dif.inject { |sum, num| sum + num }.to_f
    Math.sqrt(added / (@days_of_week_invoice_count.count - 1)).round(2)
  end

  def top_days_by_invoice_count
    zipped = @days_of_week_invoice_count.zip(@days)
    average = @avg_invoices_per_day
    stdev = @invoices_per_day_stdev
    found = zipped.find_all { |invoice| invoice[0] > (average + (stdev * 1)) }
    found.map { |day| day[1] }
  end

  def invoice_status(status)
    numerator = @invoice_repo.find_all_by_status(status).count.to_f
    denominator = @invoices.count
    ((numerator / denominator) * 100).round 2
  end
end

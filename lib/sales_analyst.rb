require_relative 'sales_engine'
require 'BigDecimal'
require 'date'

class SalesAnalyst
  def initialize(items_path, merchants_path, invoices_path, invoice_items_path, transactions_path, customers_path)
    @items = items_path
    @merchants = merchants_path
    @invoices = invoices_path
    @invoice_items = invoice_items_path
    @transactions = transactions_path
    @customers = customers_path
  end

  def merchant_items_hash
    merchants_items_hash = @items.all.group_by do |item|
      item.merchant_id
    end
    merchants_items_hash.map do |keys, values|
      merchants_items_hash[keys] = values.count
    end
    merchants_items_hash
  end

  def merchant_invoices_hash
    merchant_invoices_hash = @invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
    merchant_invoices_hash.map do |keys, values|
      merchant_invoices_hash[keys] = values.count
    end
    merchant_invoices_hash
  end

  def average_items_per_merchant
    merchants = merchant_items_hash.keys.count
    items = merchant_items_hash.values.sum.to_f
    average_per = (items.to_f / merchants.to_f)
    average_per.round(2)
  end

  def average_items_per_merchant_standard_deviation
    squared_differences = 0.0
    merchant_items_hash.each do |merchant, items|
      squared_differences += (items - average_items_per_merchant)**2
    end
    stdev = (squared_differences / (merchant_items_hash.keys.count - 1))**0.5
    stdev.round(2)
  end

  def merchants_with_high_item_count
    average_items = average_items_per_merchant
    stdev = average_items_per_merchant_standard_deviation
    one_above_stdev_merchants = merchant_items_hash.find_all do |key, value|
      value >= (average_items + stdev)
    end
    one_above_stdev_merchants.map {|id, _| @merchants.find_by_id(id)}
  end

  def average_item_price_for_merchant(merchant_id_search)
    items_to_avg = @items.find_all_by_merchant_id(merchant_id_search)
    total_price = BigDecimal("0")
    items_to_avg.each do |item|
      total_price += item.unit_price
    end
    average_price = (total_price / items_to_avg.count).round(2)
  end

  def average_average_price_per_merchant
    average_price_array = []
    @merchants.all.each do |merchant|
      average_price_array << average_item_price_for_merchant(merchant.id)
    end
    average_average_price = (average_price_array.sum / average_price_array.count).round(2)
  end

  def average_price_per_item
    all_prices = []
    @items.all.each do |item|
      all_prices << item.unit_price
    end
    average_price = all_prices.sum / all_prices.count
  end

  def average_price_per_item_standard_deviation
    average_price = average_price_per_item
    squared_differences = 0.0
    @items.all.each do |item|
      squared_differences += (item.unit_price - average_price)**2
    end
    total_items = @items.all.count
    stdev = (squared_differences / (total_items - 1))**0.5
  end

  def golden_items
    average_price = average_price_per_item
    stdev = average_price_per_item_standard_deviation
    golden_items = @items.all.find_all do |item|
      item.unit_price >= (average_price + (stdev * 2))
    end
    golden_items
  end

  def average_invoices_per_merchant
    merchants = merchant_items_hash.keys.count
    invoices = @invoices.all.count
    average_per = (invoices.to_f / merchants)
    average_per.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    squared_differences = 0.0
    merchant_invoices_hash.each do |merchant, invoices|
      squared_differences += (invoices - average_invoices_per_merchant)**2
    end
    stdev = (squared_differences / (merchant_invoices_hash.keys.count - 1))**0.5
    stdev.round(2)
  end

  def top_merchants_by_invoice_count
    two_above_stdev = average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation)
    merchant_invoices_count = merchant_invoices_hash
    top_merchs = merchant_invoices_count.find_all do |merchant, invoices|
      invoices >= two_above_stdev
    end
    top_merchs = top_merchs.map { |merchant| @merchants.find_by_id(merchant[0])}
  end

  def bottom_merchants_by_invoice_count
    two_below_stdev = average_invoices_per_merchant - (2 * average_invoices_per_merchant_standard_deviation)
    merchant_invoices_count = merchant_invoices_hash
    bot_merchs = merchant_invoices_count.find_all do |merchant, invoices|
      invoices <= two_below_stdev
    end
    bot_merchs = bot_merchs.map { |merchant| @merchants.find_by_id(merchant[0])}
    require 'pry'; binding.pry
  end


  # On which days are invoices created at more than one standard deviation above the mean?
  # sales_analyst.top_days_by_invoice_count # => ["Sunday", "Saturday"]

  # Date.parse(day).strftime('%A')

  def day_invoices_hash
    day_invoices_hash = @invoices.all.group_by do |invoice|
      invoice.created_at
    end
    day_invoices_hash.map do |day, invoices|
      day_invoices_hash[keys] = invoices.count
    end
    day_invoices_hash
  end

  def average_invoices_per_day
    #we need to get a count of invoices by day
  end

  def average_invoices_per_day_standard_deviation

  end

  def top_days_by_invoice_count
    one_above_stdev = (average_invoices_per_day + average_invoices_per_day_standard_deviation)
    # use that shit to get our output
    #.strftime('%m/%d/%Y')
  end

  def invoice_status(status)
    count_of_status = @invoices.find_all_by_status(status.to_s).count
    percentage = (count_of_status.to_f / @invoices.all.count) * 100
    percentage.round(2)
  end

end

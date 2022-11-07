require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine, :items, :merchants, :invoices

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @items = sales_engine.items.all
    @merchants = sales_engine.merchants.all
    @invoices = sales_engine.invoices.all
  end

  def average_items_per_merchant
    (items.count / merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(diff_items_per_merchant / (merchants.count - 1)).round(2)
  end

  def diff_items_per_merchant
    merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum + (merchant_items.count - average_items_per_merchant)**2
    end
  end
  
  def merchants_with_high_item_count
    double = average_items_per_merchant_standard_deviation * 2
    merchants.find_all do |merchant|
      sales_engine.items.find_all_by_merchant_id(merchant.id).count > double
    end
  end
  
  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.items.find_all_by_merchant_id(merchant_id)
    if items.empty?
      BigDecimal(0)
    else
      price = items.sum do |item|
        item.unit_price
      end
      (price / items.count).round(2)
    end
  end
  
  def average_average_price_per_merchant
    total_price = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.sum
    (total_price / merchants.count).round(2)
  end
  
  def golden_items
    prices = items.map { |item| item.unit_price }
    avg = (prices.sum / prices.count).round(2)
    std_dev = Math.sqrt(total_diff(prices, avg) / (prices.length - 1)).round(2)
    items.find_all do |item|
      item.unit_price.to_f >= avg+ (std_dev * 2)
    end
  end

  def total_diff(prices, avg)
    prices.inject(0) do |sum, price|
      sum + (price - avg)**2
    end.round(2)
  end

  def average_invoices_per_merchant
   (@invoices.count/@merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = merchants_invoices.inject(0) do |sum, invoice|
      sum += (invoice.count - mean)**2
    end
    return Math.sqrt(sum/(merchants.length - 1)).round(2)
  end

  def merchants_invoices
    @merchants.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id)
    end
  end

end

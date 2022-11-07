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
    total_diff = merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum + (merchant_items.count - average_items_per_merchant)**2
    end
    Math.sqrt(total_diff / (merchants.length - 1)).round(2)
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
    total_diff = prices.inject(0) do |sum, price|
      sum + (price - avg)**2
    end.round(2)
    std_dev = Math.sqrt(total_diff / (prices.length - 1)).round(2)
    items.find_all do |item|
      item.unit_price.to_f >= avg+ (std_dev * 2)
    end
  end

  def average_invoices_per_merchant
   (@invoices.count/@merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = merchant_invoices.inject(0) do |sum, invoice|
      sum += (invoice.count - mean)**2
    end
    return Math.sqrt(sum/(merchants.length - 1)).round(2)
  end

  def merchant_invoices
    @merchants.map do |merchant|
      sales_engine.invoices.find_all_by_merchant_id(merchant.id)
    end
  end
  
end
  # def golden_items
  #   prices = items.map { |item| item.unit_price }
  #   # avg(prices)
  #   # std_dev(prices)
  #   avg = (prices.sum / prices.count).round(2)
  #   total_diff = prices.inject(0) do |sum, price|
  #     sum + (price - avg)**2
  #   end.round(2)
  #   # std_dev = std_dev(total_diff, prices)
  #   std_dev = Math.sqrt(total_diff / (prices.length - 1)).round(2)
  #   items.find_all do |item|
  #     item.unit_price.to_f >= avg(prices)+ (std_dev * 2)
  #   end
  # end


  # def std_dev(sample)
  #   avg = avg(sample)
  #   std_dev_calc(total_diff(sample, avg), sample)
    
  # end
  
  # def avg(sample)
  #   (sample.sum / sample.count).round(2)
  # end

  # def total_diff(sample, avg)
  #   sample.inject(0) do |sum, instance|
  #     sum + (instance - avg)**2
  #   end.round(2)
    
  # end
  

  # def std_dev_calc(difference, sample)
  #   Math.sqrt(difference / (sample.length - 1)).round(2)
  # end
  
  # # def total_diff(sample)
  # # end
# end

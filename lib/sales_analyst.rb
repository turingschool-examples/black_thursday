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
    avg = average_items_per_merchant
    total_diff = merchants.inject(0) do |sum, merchant|
      merchant_items = sales_engine.items.find_all_by_merchant_id(merchant.id)
      sum + (merchant_items.count - avg)**2
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
    end.inject(0, :+)
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

  def golden_items_std_dev
   
  end

  def average_invoices_per_merchant
   (@invoices.count/@merchants.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sample_sum = 0
    merchants_with_invoices.each do |invoices_array|
      sample_sum += (invoices_array.count - mean)**2
    end
    return Math.sqrt(sample_sum/(uniq_merchant_ids.length - 1)).round(2)
  end

  def uniq_merchant_ids
    invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def merchants_with_invoices
    uniq_merchant_ids.map do |merchant_id|
      sales_engine.invoices.find_all_by_merchant_id(merchant_id)
    end
  end

  def top_merchants_by_invoice_count
    top_merchants_invoices = []
     merchants_with_invoices.each do |invoices_array|
      if invoices_array.count > (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
      top_merchants_invoices.push(invoices_array)
      end
    end
    merchant_ids_collection = []
    top_merchants_invoices.each do |invoices_collection|
      merchant_ids_collection.push(invoices_collection[0].merchant_id)
    end
    chosen_merchants = []
    merchant_ids_collection.each do |merchant|
      chosen_merchants.push(@sales_engine.merchants.find_by_id(merchant))
    end
    chosen_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants_invoices = []
     merchants_with_invoices.each do |invoices_array|
      if invoices_array.count < (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
      bottom_merchants_invoices.push(invoices_array)
      end
    end
    merchant_ids_collection = []
    bottom_merchants_invoices.each do |invoices_collection|
      merchant_ids_collection.push(invoices_collection[0].merchant_id)
    end
    chosen_merchants = []
    merchant_ids_collection.each do |merchant|
      chosen_merchants.push(@sales_engine.merchants.find_by_id(merchant))
    end
    chosen_merchants
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

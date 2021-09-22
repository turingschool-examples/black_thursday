require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'
require './lib/invoice_repository'
require './lib/invoice'
require 'csv'
require 'pry'
require 'date'

class SalesAnalyst
  attr_reader :analyst_items,
              :analyst_merchants,
              :store_hashes,
              :average_items_per_merchant,
              :average_item_price,
              :all_item_prices,
              :every_stores_average,
              :analyst_invoices

  def initialize(data)
    @analyst_items = data[:items]
    @analyst_merchants = data[:merchants]
    @analyst_invoices = data[:invoices]
  end

  def average_items_per_merchant
    (@analyst_items.all.count.to_f / @analyst_merchants.all.count.to_f).round(2)
  end

  #helper method
  def store_hashes
    store_hashes = []
    stores_items = []
    @analyst_merchants.all.each do |merchant|
      stores_items = []
      @analyst_items.all.each do |item|
        if item.merchant_id == merchant.id
          stores_items << item
        end
      end
     store_hashes << {
       :merchant => merchant,
       :stores_items => stores_items,
       :item_count => stores_items.count}
     end
     store_hashes
  end

  def average_items_per_merchant_standard_deviation
    sum = 0
    aipm = average_items_per_merchant
    store_hashes.each do |store|
      sum += (store[:item_count] - aipm)**2
    end
    std = Math.sqrt(sum / store_hashes.count).round(2)
    std
  end

   def merchants_with_high_item_count
     std = average_items_per_merchant_standard_deviation
     aipm = average_items_per_merchant
     mwhic = []
     store_hashes.each do |store|
       if store[:item_count] > aipm + std
         mwhic << store[:merchant]
       end
     end
     mwhic
   end

  def average_item_price_for_merchant(merchant_id)

    store_to_analyze = 0
    number_of_items = 0
    sum = 0
    store_hashes.each do |store|
      if store[:merchant].id == merchant_id
        store_to_analyze = store
      end
    end
    store_to_analyze[:stores_items].each do |item|
      number_of_items += 1
      sum += item.unit_price.to_i
    end
    (sum.to_f / number_of_items.to_f).round(2)

  end

  def every_stores_average
    every_stores_average = []
    store_hashes.each do |store|
      every_stores_average << average_item_price_for_merchant(store[:merchant].id)
    end
    every_stores_average
  end

  def average_average_price_per_merchant
    esa = every_stores_average
    (esa.sum.to_f / esa.count).round(2)
  end

  #helper method
  def all_item_prices
    all_item_prices = []
    @analyst_items.all.each do |item|
      all_item_prices << item.unit_price.to_i
    end
    all_item_prices
  end

  #helper method
  def average_item_price
    all_item_prices.sum.to_f / all_item_prices.count
  end

  #helper method
  def standard_deviation_of_all_item_prices
    sum = 0
    aip = average_item_price
      all_item_prices.each do |item|
      sum += (item - aip)**2
    end
    std = Math.sqrt(sum / all_item_prices.count).round(2)
    std
  end

  def golden_items
    golden_items = []
    @analyst_items.all.each do |item|
      if item.unit_price.to_i > (average_item_price + (standard_deviation_of_all_item_prices * 2))
        golden_items << item
      end
    end
    golden_items
  end

  def average_invoices_per_merchant
    (@analyst_invoices.all.count.to_f / @analyst_merchants.all.count.to_f).round(2)
  end

  #helper method
  def invoice_hashes
    invoice_hashes = []
    @analyst_merchants.all.each do |merchant|
      merchants_invoices = []
      @analyst_invoices.all.each do |invoice|
        if invoice.merchant_id == merchant.id
          merchants_invoices << invoice
        end
      end
     invoice_hashes << {
       :merchant => merchant,
       :merchants_invoices => merchants_invoices,
       :invoice_count => merchants_invoices.count}
     end
     invoice_hashes
  end

  def average_invoices_per_merchant_standard_deviation
    sum = 0
    aipm = average_invoices_per_merchant
    invoice_hashes.each do |invoice_hash|
      sum += (invoice_hash[:invoice_count] - aipm)**2
    end
    std = Math.sqrt(sum / invoice_hashes.count).round(2)
    std
  end

  def top_merchants_by_invoice_count
    std = average_invoices_per_merchant_standard_deviation
    aipm = average_invoices_per_merchant
    mwhic = []
    invoice_hashes.each do |invoice_hash|
      if invoice_hash[:invoice_count] > aipm + (std * 2)
        mwhic << invoice_hash[:merchant]
      end
    end
    mwhic
  end

  def bottom_merchants_by_invoice_count
    std = average_invoices_per_merchant_standard_deviation
    aipm = average_invoices_per_merchant
    mwlic = []
    invoice_hashes.each do |invoice_hash|
      if invoice_hash[:invoice_count] < aipm - (std * 2)
        mwlic << invoice_hash[:merchant]
      end
    end
    mwlic
  end

  #helper method
  def days_by_invoice_hash
    by_days = []
    @analyst_invoices.all.each do |invoice|
      by_days << Date.parse(invoice.created_at).strftime("%A")
      end
    dotw = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    container = []
    dotw.each do |day|
      container << (by_days.find_all do |invoice_day|
      day == invoice_day
      end.count)
    end
    h = Hash[dotw.zip container]
    h
  end

  #helper method
  def average_invoices_per_day
    average_invoices_per_day = (
      days_by_invoice_hash.values.sum / days_by_invoice_hash.values.count.to_f)
  end

  #helper method
  def average_invoices_per_day_standard_deviation
    sum = 0
    aipd = average_invoices_per_day
    days_by_invoice_hash.values.each do |v|
      sum += (v - aipd)**2
    end
  std = Math.sqrt(sum / 7)
  std
  end

  def top_days_by_invoice_count
    top_days = []
    aipd = average_invoices_per_day
    std = average_invoices_per_day_standard_deviation
    day = days_by_invoice_hash
    day.each do |k, v|
      if (v > (aipd + std))
      top_days << k
      end
    end
    top_days
  end

  def all_invoice_statuses
    all_invoice_statuses = []
    analyst_invoices.all.each do |invoice|
      all_invoice_statuses << invoice.status
    end
    all_invoice_statuses
  end

  def invoice_status_hasher
    ais = all_invoice_statuses
    possible_statuses = ["pending", "shipped", "returned"]
    container = []
    ais.each do |status|
      container << (ais.find_all do |possible_status|
        status == possible_status
        end.count)
    end
    ais_symbols = []
    ais.each do |status|
      ais_symbols << status.to_sym
    end
  h = Hash[ais_symbols.zip container]
  h
  end

  def invoice_status(status)
    total = invoice_status_hasher.values.sum.to_f
    x = invoice_status_hasher[status].to_f
    (( x / total ) * 100).round(2)
  end

end

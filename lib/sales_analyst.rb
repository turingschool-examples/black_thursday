require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/item'
require './lib/merchant'
require './lib/invoice_repository'
require './lib/invoice'
require 'csv'
require 'pry'

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

  def all_item_prices
    all_item_prices = []
    @analyst_items.all.each do |item|
      all_item_prices << item.unit_price.to_i
    end
    all_item_prices
  end

  def average_item_price
    all_item_prices.sum.to_f / all_item_prices.count
  end

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

end

require 'bigdecimal'
require 'pry'

class SalesAnalyst
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository,
              :invoice_item_repository,
              :customer_repository

  def initialize(item_repository, merchant_repository, invoice_repository, invoice_item_repository, customer_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
    @invoice_repository = invoice_repository
    @invoice_item_repository = invoice_item_repository
    @customer_repository = customer_repository
  end

  def average_items_per_merchant
   (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = items_per_merchant.values.sum(0.0) {|item| (item - mean) ** 2}
    variance = (sum / (items_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg_items = average_items_per_merchant
    @merchant_repository.all.find_all do |merchant|
      @item_repository.find_all_by_merchant_id(merchant.id).count > (avg_items +  std_dev)
    end
  end

  def items_per_merchant
    merchant_items = Hash.new
    item_count = 0
    @merchant_repository.all.each do |merchant|
      item_count = @item_repository.find_all_by_merchant_id(merchant.id).size
      merchant_items[merchant.id] = item_count
    end
    merchant_items
  end
  #The average of one merchant's prices
  def average_item_price_for_merchant(id)
    merchant_items = @item_repository.find_all_by_merchant_id(id)
    price_sum = merchant_items.sum(0.0) {|item| item.unit_price}
    (price_sum / merchant_items.count).round(0)
  end
  #The average price per item across all merchants
  def average_average_price_per_merchant
    merchant_averages =[]
    @merchant_repository.all.each do |merchant|
      merchant_averages << average_item_price_for_merchant(merchant.id)
    end
    merchant_averages.sum(0.0) / merchant_averages.count
  end
  def average_price_per_merchant_standard_deviation
    mean = average_average_price_per_merchant
    sum = price_averages_per_merchant.values.sum(0.0) {|price| (price - mean) ** 2}
    variance = (sum / (price_averages_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end
  #hash holding each merchant's average price/item
  def price_averages_per_merchant
    merchant_price_averages = Hash.new
    @merchant_repository.all.each do |merchant|
      merchant_price_averages[merchant.id] = average_item_price_for_merchant(merchant.id)
    end
    merchant_price_averages
  end

  def golden_items
    avg_avg_price = average_average_price_per_merchant
    std_dev = average_price_per_merchant_standard_deviation
    @item_repository.all.find_all do |item|
      item.unit_price > (avg_avg_price + (std_dev * 2))
    end
  end
  #The average invoices per merchant
  def average_invoices_per_merchant
    invoices = @invoice_repository.all.count.to_f
    merchants = @merchant_repository.all.count.to_f
    (invoices / merchants).round(2)
  end
  def invoices_per_merchant
    invoice_items = Hash.new
    invoice_count = 0
    @merchant_repository.all.each do |merchant|
      invoice_count = @invoice_repository.find_all_by_merchant_id(merchant.id).size
      invoice_items[merchant.id] = invoice_count
    end
    invoice_items
  end
  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = invoices_per_merchant.values.sum(0.0) {|item| (item - mean) ** 2}
    variance = (sum / (invoices_per_merchant.size - 1)).to_f
    standard_deviation = Math.sqrt(variance).round(2)
  end
  def top_merchants_by_invoice_count
    top_merchants = []
    avg_invoices = average_invoices_per_merchant
    std_dev_2 = average_invoices_per_merchant_standard_deviation * 2
    invoice_items = invoices_per_merchant.find_all {|count| count[1] > (avg_invoices + std_dev_2)}
    invoice_items.each do | merchant_id |
      top_merchants << @merchant_repository.find_by_id(merchant_id[0])
    end
    top_merchants
  end
end

require 'csv'
require 'bigdecimal/util'
require_relative 'sales_engine'
require_relative 'item'
require_relative 'merchant'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices
  def initialize(item_repo = nil, merchant_repo = nil, invoice_repo = nil)
    @items = item_repo
    @merchants = merchant_repo
    @invoices = invoice_repo
  end

  def item_count
    items.all.count
  end

  def items_per_merchant(id)
    items.find_all_by_merchant_id(id).count
  end

  def merchant_count
    merchants.all.count
  end

  def average_items_per_merchant
    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @merchants.all.map do |merchant|
      @items.find_all_by_merchant_id(merchant.id).count
    end
    average = average_items_per_merchant
    differences = 0
    merchants.map do |num|
      differences += (num - average)**2
    end
    Math.sqrt(differences / (merchants.count - 1).to_f).round(2)
  end

  def average_item_price_for_merchant(id)
    stock = (items.find_all_by_merchant_id(id))
    price_array = stock.map {|stock| stock.unit_price }.sum
    @average_item_price = (price_array / stock.count).round(2)
    @average_item_price
  end

  def average_average_price_per_merchant
    sellers = merchants.all
    array = []
    sellers.each do |seller|
      array << self.average_item_price_for_merchant(seller.id)
    end
    (array.sum / sellers.count).round(2)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @merchants.all.find_all { |merchant| items_per_merchant(merchant.id) > threshold }
  end

  def golden_items
    unit_price_sum = @items.all.map {|item| item.unit_price }.sum
    price_average = unit_price_sum / @items.all.count
    difference_sum = @items.all.map {|item| (price_average - item.unit_price)**2 }.sum
    price_stdrd_dev = Math.sqrt((difference_sum / @items.all.count).abs)
    @items.all.find_all  {|item|  item.unit_price > price_average + (price_stdrd_dev * 2)}
  end

  def invoice_quantity_per_merchant
    merchant_ids = @invoices.all.map { |invoice| invoice.merchant_id}
    hash = Hash.new(0)
    merchant_ids.each do |id|
      hash[id] += 1
    end
    invoices_per_merchant = hash.values.sort
  end

  def merchant_invoice_num(merchant_id)
    invoice_num = 0
    @invoices.all.each do |invoice|
      if invoice.merchant_id == merchant_id
        invoice_num += 1
      end
    end
    invoice_num
  end

  def average_invoices_per_merchant
    (invoice_quantity_per_merchant.sum.to_f / invoice_quantity_per_merchant.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    difference_sum = invoice_quantity_per_merchant.map {|invoice_quantity| (average_invoices_per_merchant - invoice_quantity)**2 }.sum
    price_stdrd_dev = Math.sqrt((difference_sum.to_f / invoice_quantity_per_merchant.count).abs).round(2)
  end

  def top_merchants_by_invoice_count
    @merchants.all.find_all { |merchant| merchant_invoice_num(merchant.id) > average_invoices_per_merchant + average_items_per_merchant_standard_deviation * 2}
  end

end

require_relative './sales_engine'
require_relative '../module/incravinable'


class SalesAnalyst
  include Incravinable

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    @sales_engine.all_items.length.fdiv(@sales_engine.all_merchants.length).round(2)
  end

  def number_items_per_merchant
    item_merchant_hash = {}
    @sales_engine.all_merchants.each do |merchant|
      item_merchant_hash[merchant] = @sales_engine.items.find_all_by_merchant_id(merchant.id).length
    end
    item_merchant_hash
  end

  def avg(data)
    data.sum.fdiv(data.count)
  end

  def std_dev(data)
    numerator = data.reduce(0) do |sum, num|
      sum + (num - avg(data))**2
    end
    Math.sqrt(numerator/(data.count - 1)).round(2)
  end
  #why the -1 ???

  def average_items_per_merchant_standard_deviation
    std_dev(self.number_items_per_merchant.values).round(2)
  end

  def merchants_with_high_item_count
    top_merchants = []
    sigma = (average_items_per_merchant_standard_deviation + average_items_per_merchant)
    number_items_per_merchant.find_all do |merchant, quantity|
      if quantity > sigma
        top_merchants << merchant
      end
    end
    top_merchants
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.all_items
    merchant_items = @sales_engine.find_all_with_merchant_id(merchant_id, items)
    sum = merchant_items.sum do |item|
      item.unit_price
    end
    (sum / merchant_items.length).round(2)
  end

  def average_average_price_per_merchant
    average_array = []
    @sales_engine.all_merchants.each do |merchant|
    average_array << average_item_price_for_merchant(merchant.id)
    end
    (average_array.sum / average_array.length).round(2)
  end

  def golden_items
    price_array = []
    @sales_engine.all_items.each do |item|
     price_array << item.unit_price
    end
    std_dev_prices = std_dev(price_array)
    sigma2 = ((std_dev_prices * 2) + average_average_price_per_merchant)
    top_items = []
    @sales_engine.all_items.each do |item|
      top_items << item if item.unit_price > sigma2
    end
    top_items
  end

  def average_invoices_per_merchant
    @sales_engine.all_invoices.length.fdiv(@sales_engine.all_merchants.length).round(2)
  end

  def number_invoices_per_merchant
    invoices_merchant_hash = {}
    @sales_engine.all_merchants.each do |merchant|
      invoices_merchant_hash[merchant] = @sales_engine.invoices.find_all_by_merchant_id(merchant.id).length
    end
    invoices_merchant_hash
  end

  def average_invoices_per_merchant_standard_deviation
    std_dev(self.number_invoices_per_merchant.values).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    sigma2 = ((average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant)
    number_invoices_per_merchant.find_all do |merchant, quantity|
      top_merchants << merchant if quantity > sigma2
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    sigma2 = (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
    number_invoices_per_merchant.find_all do |merchant, quantity|
      bottom_merchants << merchant if quantity < sigma2
    end
    bottom_merchants
  end

  # def mediocre_merchants_by_invoice_count
  #   mediocre_merchants = []
  #   sigma = (average_invoices_per_merchant_standard_deviation + average_invoices_per_merchant)
  #   number_invoices_per_merchant.find_all do |merchant, quantity|
  #     mediocre_merchants << merchant.id if quantity > sigma
  #   end
  #   mediocre_merchants
  # end
  def average_invoices_per_day
    hash = Hash.new { |hash, key| hash[key] = Array.new }
    @sales_engine.all_invoices.each do |invoice|
      hash[invoice.created_at] << invoice
    end
    num_keys = hash.keys.count
    average = (@sales_engine.all_invoices.length.fdiv(num_keys)).round(2)
    require 'pry'; binding.pry
    # num_values = hash.each_value do |value|
    #   if value != nil
    #     value.count
    #   end
    #   (num_values / num_keys)
    # end
  end

  # def top_days_by_invoice_count
  #   top_invoices = mediocre_merchants_by_invoice_count.flat_map do |id|
  #     @sales_engine.invoices.find_all_by_merchant_id(id)
  #   end
  #   all_days = top_invoices.map do |invoice|
  #     invoice.created_at.strftime('%A')
  #   end
  #   all_days.max_by { |day| all_days.include?(day) }
  # end
end

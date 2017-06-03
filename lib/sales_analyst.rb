require 'pry'
require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    var = collected_items_array
    average = (var.reduce(0) { |sum, num| sum += num})/var.length.to_f
    average.round(2)
  end

  def average_invoices_per_merchant
    var = collected_invoices_array
    average = (var.reduce(0) { |sum, num| sum += num})/var.length.to_f
    average.round(2)
  end


  def collected_items_array
      all_merchants = []
      merchant_array = @sales_engine.merchants.all
      merchant_array.each do |merchant|
        item = merchant.items
        all_merchants << item.length
      end
      all_merchants
  end

  def collected_invoices_array
      all_invoices = []
      merchant_array = @sales_engine.merchants.all
      merchant_array.each do |merchant|
        invoice = merchant.invoices
        all_merchants << invoice.length
      end
      all_invoices
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation
  end

  def standard_deviation
    array_1 = collected_items_array
    average = average_items_per_merchant
    array_2 = array_1.map{|num| (num-average)**2}
    final = Math.sqrt((array_2.reduce(:+))/(array_2.length-1))
    final.round(2)
  end

  def merchants_with_high_item_count
    mr = sales_engine.merchants.all
    var = average_items_per_merchant + average_items_per_merchant_standard_deviation
    mr.find_all do |merchant|
      merchant.items.length >= var
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = sales_engine.collected_items(merchant_id)
    sum = 0
    items.each do |item|
      sum += item.unit_price
    end
    average = sum/(items.length)
    average.round(2)
  end

  def average_average_price_per_merchant
    array_1 = []
    sales_engine.merchants.all.each do |merch|
      id = merch.id
      array_1 << average_item_price_for_merchant(id)
    end
    array_2 = (array_1.reduce(:+)/array_1.length)
    array_2.round(2)
  end

  def golden_items
    ir = sales_engine.items.all
    prices = ir.map {|item| item.unit_price}
    dev = (average_average_price_per_merchant) + (standard_deviation * 2)
    ir.find_all do |item|
      item.unit_price >= dev
    end
  end

end

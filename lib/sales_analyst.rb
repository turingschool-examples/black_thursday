require 'bigdecimal'
class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    items = @engine.items.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (items / merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchants = @engine.merchants.all
    average = average_items_per_merchant
    standard_deviation(merchants, average, 'item')
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant +
                (average_items_per_merchant_standard_deviation * 1)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.items.find_all_by_merchant_id(merchant.id).count
      merch_count > threshold
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @engine.items.find_all_by_merchant_id(merchant_id)
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def average_average_price_per_merchant
    merchants = @engine.merchants.all
    total_cost = 0.0
    merchants.each do |merchant|
      total_cost += average_item_price_for_merchant(merchant.id)
    end
    (total_cost / merchants.count).round(2)
  end

  def average_item_cost
    items = @engine.items.all
    total_cost = 0.0
    items.each do |item|
      total_cost += item.unit_price
    end
    (total_cost / items.count).round(2)
  end

  def golden_items
    threshold = average_item_cost +
                (item_unit_price_standard_deviation * 2)
    @engine.items.all.find_all do |item|
      item.unit_price > threshold
    end
  end

  def item_unit_price_standard_deviation
    items = @engine.items.all
    average = average_item_cost
    standard_deviation(items, average, 'item')
  end

  def standard_deviation(elements, average, decider)
    deviation_sum = 0
    elements.each do |element|
      deviation_sum += (element.value(decider).to_f - average).abs ** 2
    end
    divided_deviation = deviation_sum / (elements.count - 1)
    Math.sqrt(divided_deviation).round(2).to_f
  end

  def average_invoices_per_merchant
    invoices = @engine.invoices.elements.count.to_f
    merchants = @engine.merchants.elements.count.to_f
    (invoices / merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    merchants = @engine.merchants.all
    average = average_invoices_per_merchant
    standard_deviation(merchants, average, 'invoice')
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant +
                (average_invoices_per_merchant_standard_deviation * 2)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.invoices.find_all_by_merchant_id(merchant.id).count
      merch_count > threshold
    end
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant -
                (average_invoices_per_merchant_standard_deviation * 2)
    @engine.merchants.all.find_all do |merchant|
      merch_count = @engine.invoices.find_all_by_merchant_id(merchant.id).count
      merch_count < threshold
    end
  end
end

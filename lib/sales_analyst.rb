require_relative 'maths'

class SalesAnalyst
  include Maths
  attr_reader :se

  def initialize(parent)
    @se = parent
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f / @se.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @merchant_stock = @se.items.all.group_by do |item|
      item.merchant_id
    end
    @totals = @merchant_stock.map do |merchant, items|
      [items.count.to_d]
    end
     standard_deviation(@totals.flatten)
  end

  def average_invoices_per_merchant
    total_merchants = @se.merchants.all.count
    total_invoices = @se.invoices.all.count
    BigDecimal((total_invoices.to_d / total_merchants), 3).round(2).to_f
  end

  def top_merchants_by_invoice_count
    cutoff = average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation
    high_count = @se.merchants.all.map do |merchant|
    if @merchant_stock[merchant.id]

      if ((@merchant_stock[merchant.id]).count - cutoff) >= 0
      merchant
      end
    end
  end
    high_count.compact
  end



  def merchants_with_high_item_count
   cutoff = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count = @se.merchants.all.map do |merchant|
    if @merchant_stock[merchant.id]
      if ((@merchant_stock[merchant.id]).count - cutoff) >= 0
      merchant
      end
    end
  end
    high_count.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @se.items.find_all_by_merchant_id(merchant_id)
    sum_of_prices = merchant_items.inject(0) do |sum, item|
      sum + (item.unit_price)
    end
    (sum_of_prices / merchant_items.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_items =  @se.items.all.group_by do |item|
      item.merchant_id
    end
    @merchant_id_keys = merchant_items.keys
    average_average_price = @merchant_id_keys.inject(0) do |sum, id|
     sum += average_item_price_for_merchant(id)
    end / @merchant_id_keys.count
    average_average_price.round(2)
  end

  def item_price_standard_deviation
    mean = average_average_price_per_merchant
    sum_of_squares = @se.items.all.inject(0.0) do |sum, item|
      ((item.unit_price - mean)**2) + sum
    end / (@se.items.all.count - 1)
    Math.sqrt(sum_of_squares).round(2)
  end

  def golden_items
    two_above = average_average_price_per_merchant +
      (item_price_standard_deviation * 2)
    @se.items.all.find_all { |item| item.unit_price > two_above }
  end
end

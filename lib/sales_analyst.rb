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

  def merchant_stock
    @se.items.all.group_by do |item|
      item.merchant_id
    end
  end

  def total_inventory
    merchant_stock.map do |merchant, items|
      [items.count.to_d]
    end
  end

  def average_items_per_merchant_standard_deviation
     standard_deviation(total_inventory.flatten)
  end

  def merchants_with_high_item_count
   cutoff = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_count = @se.merchants.all.map do |merchant|
    if merchant_stock[merchant.id]
      if ((merchant_stock[merchant.id]).count - cutoff) >= 0
      merchant
      end
    end
  end
    high_count.compact
  end

  def prices
    @se.items.all.map { |item| item.unit_price }
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_items = @se.items.find_all_by_merchant_id(merchant_id)
    merchant_prices = merchant_items.map { |item| item.unit_price }
    mean(merchant_prices).round(2)
  end

  def average_price_per_merchant
    merchant_ids = @se.merchants.all.map { |merchant| merchant.id }
    merchant_ids.map { |id| average_item_price_for_merchant(id) }
  end

  def average_average_price_per_merchant
    mean(average_price_per_merchant).round(2)
  end

  def price_standard_deviation
     standard_deviation(prices)
  end

  def golden_items
    two_above = average_average_price_per_merchant + (price_standard_deviation * 2)
    @se.items.all.find_all { |item| item.unit_price > two_above }
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

end

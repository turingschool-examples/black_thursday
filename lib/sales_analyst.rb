require_relative '../lib/modules/standard_deviation'
class SalesAnalyst
  include StandardDeviation
  attr_reader :engine
  def initialize(engine = nil)
    @engine = engine
  end

  def average_items_per_merchant
    (item_amount.sum / item_amount.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(item_amount, average_items_per_merchant)
  end

  def average_item_price_std_dev
    standard_deviation(all_merchant_prices, average_average_price_per_merchant)
  end

  def item_amount
    @engine.merchants.all.map do |merchant|
      @engine.find_all_items_by_merchant_id(merchant.id).length
    end
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    @engine.merchants.all.find_all do |merchant|
      merchant.items.length >
      (average_items_per_merchant + std_dev)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    (prices(merchant_id).sum / prices(merchant_id).length).round(2)
  end

  def average_average_price_per_merchant
    averages = @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (averages.sum / averages.length).round(2)
  end

  def prices(merchant_id)
    @engine.merchants.find_by_id(merchant_id).items.map do |item|
      item.unit_price
    end
  end

  def all_merchant_prices
    @engine.merchants.all.flat_map do |merchant|
      prices(merchant.id)
    end
  end

  def golden_items
    std_dev = average_item_price_std_dev
    @engine.items.all.find_all do |item|
      item.unit_price  >
      (std_dev *
      2 +
      average_average_price_per_merchant)
    end
  end

  def average_invoices_per_merchant
    (invoice_amount.sum / invoice_amount.length.to_f).round(2)
  end

  def invoice_amount
    @engine.merchants.all.map do |merchant|
      @engine.find_all_invoices_by_merchant_id(merchant.id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_amount, average_invoices_per_merchant)
  end
end

require 'bigdecimal'
require 'date'
require_relative '../modules/statistics'
require_relative '../modules/data_set'
require_relative '../modules/merchant_analytics'
require_relative '../modules/customer_analytics'

# This is the sales analyst class
class SalesAnalyst
  include Statistics
  include DataSet
  include MerchantAnalytics
  include CustomerAnalytics
  attr_reader :sales_engine,
              :merchant_repo,
              :item_repo,
              :invoice_repo,
              :transaction_repo,
              :invoice_item_repo,
              :customer_repo
  def initialize(sales_engine)
    @merchant_repo     = sales_engine.merchants
    @item_repo         = sales_engine.items
    @invoice_repo      = sales_engine.invoices
    @transaction_repo  = sales_engine.transactions
    @invoice_item_repo = sales_engine.invoice_items
    @customer_repo     = sales_engine.customers
  end

  def items_per_merchant
    @items_per_merchant ||= merchants.map do |merchant|
      merchant.items.count
    end
  end

  def invoices_per_merchant
    @invoices_per_merchant ||= merchants.map do |merchant|
      invoice_repo.find_all_by_merchant_id(merchant.id).count
    end
  end

  def average_items_per_merchant
    @average_items_per_merchant ||= average(
      items_per_merchant, merchants.length
    ).round(2)
  end

  def average_items_per_merchant_standard_deviation
    @average_items_per_merch_stdev ||= stdev(
      items_per_merchant, average_items_per_merchant
    ).round(2)
  end

  def merchants_with_high_item_count
    merchants.find_all do |merchant|
      merchant.items.length > (
        average_items_per_merchant +
        average_items_per_merchant_standard_deviation
      )
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = merchant_repo.find_by_id(merchant_id)
    prices = merchant.items.map(&:unit_price)
    item_average_price = average(prices, prices.length)
    BigDecimal.new item_average_price, 4
  end

  def find_average_price(merchant)
    if merchant.items.empty?
      0
    else
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_average_price_per_merchant
    prices = merchants.map { |merchant| find_average_price(merchant) }
    average_average_price = average(prices, prices.length)
    BigDecimal.new(average_average_price, 0).truncate 2
  end

  def item_unit_prices
    @item_unit_prices ||= items.map(&:unit_price)
  end

  def average_item_price
    @average_item_price ||= average(
      item_unit_prices, item_unit_prices.length.round(2)
    )
  end

  def item_price_standard_deviation
    @item_price_standard_deviation ||= stdev(
      item_unit_prices, average_item_price
    ).round(2)
  end

  def golden_items
    zipped = item_unit_prices.zip(items)
    average = average_item_price
    stdev = item_price_standard_deviation
    found = zipped.find_all { |item| item[0] > (average + (stdev * 2)) }
    found.map { |item| item[1] }
  end
end

require 'bigdecimal'
require_relative './sales_engine'
require_relative './invoice_analyst'
require_relative './item_analyst'
require_relative './statistics'

class SalesAnalyst
  include InvoiceAnalyst
  include ItemAnalyst
  include Statistics

  attr_reader :se,
              :invoice_count,
              :merchant_count,
              :item_count

  def initialize(sales_engine)
    @se = sales_engine
    @invoice_count = se.invoices.invoices.length
    @merchant_count = se.merchants.merchants.length
    @item_count = se.items.items.length
  end

  def average_items_per_merchant
    averager(item_count, merchant_count)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(
      all_items_for_each_merchant,
      item_count,
      merchant_count
    )
  end

  def merchants_with_high_item_count
    minimum = minimum_for_high_items
    accumulate_merchant_items.reduce([]) do |result, (merchant_id, items)|
      result << se.merchants.find_by_id(merchant_id) if items >= minimum
      result
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id.to_s)
    BigDecimal((merchant.items.inject(0) do |sum, item|
      sum += item.unit_price
    end/merchant.items.count)).round(2)
  end

  def average_average_price_per_merchant
    BigDecimal((se.merchants.merchants.inject(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end/merchant_count)).round(2)
  end

  def golden_items
    minimum = minimum_for_golden_item
    find_golden_items(minimum)
  end
end

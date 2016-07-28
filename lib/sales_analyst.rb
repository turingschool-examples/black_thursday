require_relative '../lib/sales_engine'
require_relative '../lib/merchant_analyst'
require_relative '../lib/item_analyst'
require 'pry'

class SalesAnalyst
  attr_reader :sales_engine,
              :item_analyst,
              :merchant_analyst

  extend Forwardable
  def_delegators :@item_analyst, :golden_items
  def_delegators :@merchant_analyst, :average_items_per_merchant,
                                     :average_items_per_merchant_standard_deviation,
                                     :merchants_with_high_item_count,
                                     :average_item_price_for_merchant,
                                     :average_average_price_per_merchant

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @item_analyst = ItemAnalyst.new(all_items)
    @merchant_analyst = MerchantAnalyst.new(all_merchants)
  end

  def all_merchants
    sales_engine.merchants.all
  end

  def all_items
    sales_engine.items.all
  end

end

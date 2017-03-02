require 'date'
require_relative 'statistics'
require_relative 'item_analyst'
require_relative 'merchant_analyst'
require_relative 'invoice_analyst'
require_relative 'make_charts'

class SalesAnalyst
  include Statistics
  include ItemAnalyst
  include MerchantAnalyst
  include InvoiceAnalyst
  include MakeCharts

  attr_reader :engine,
              :merchant_items_set,
              :price_set,
              :invoice_set

  def initialize(engine)
    @engine = engine
  end

  private

  def merchant_items_set
    @merchant_items_set ||= merchants.map{ |merchant| merchant.items.count }
  end

  def price_set
    @price_set ||= items.map { |item| item.unit_price_to_dollars}
  end

  def invoice_set
    @invoice_set ||= merchants.map{|merchant| merchant.invoices.count}
  end

end

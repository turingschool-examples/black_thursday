require 'bigdecimal'
require_relative 'statistics'
require_relative 'date_accessor'
require_relative 'items_count_analyst'
require_relative 'items_price_analyst'
require_relative 'invoice_count_analyst'
require_relative 'merchants_revenue_analyst'

class SalesAnalyst
  include Statistics
  extend Forwardable

  attr_reader :engine, :items_count_analyst, :items_price_analyst, :invoice_count_analyst, :merchants_revenue_analyst

  def initialize(engine)
    @engine = engine
    @items_count_analyst = ItemsCountAnalyst.new(engine)
    @items_price_analyst = ItemsPriceAnalyst.new(engine)
    @invoice_count_analyst = InvoiceCountAnalyst.new(engine)
    @merchants_revenue_analyst = MerchantsRevenueAnalyst.new(engine)
  end

  def_delegator :items_count_analyst, :average_items_per_merchant
  def_delegator :items_count_analyst, :average_items_per_merchant_standard_deviation
  def_delegator :items_count_analyst, :merchants_with_high_item_count
  def_delegator :items_count_analyst, :merchants_with_only_one_item
  def_delegator :items_count_analyst, :merchants_with_only_one_item_registered_in_month
  def_delegator :items_price_analyst, :average_item_price_for_merchant
  def_delegator :items_price_analyst, :average_average_price_per_merchant
  def_delegator :items_price_analyst, :golden_items
  def_delegator :invoice_count_analyst, :merchant_invoice_count
  def_delegator :invoice_count_analyst, :average_invoices_per_merchant
  def_delegator :invoice_count_analyst, :average_invoices_per_merchant_standard_deviation
  def_delegator :invoice_count_analyst, :top_merchants_by_invoice_count
  def_delegator :invoice_count_analyst, :bottom_merchants_by_invoice_count
  def_delegator :invoice_count_analyst, :top_days_by_invoice_count
  def_delegator :invoice_count_analyst, :invoice_status
  def_delegator :invoice_count_analyst, :merchants_with_pending_invoices
  def_delegator :merchants_revenue_analyst, :total_revenue_by_date
  def_delegator :merchants_revenue_analyst, :top_revenue_earners
  def_delegator :merchants_revenue_analyst, :merchants_ranked_by_revenue
  def_delegator :merchants_revenue_analyst, :revenue_by_merchant
  def_delegator :merchants_revenue_analyst, :best_item_for_merchant
  def_delegator :merchants_revenue_analyst, :most_sold_item_for_merchant

end
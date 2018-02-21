require_relative '../lib/sales_engine'
require_relative '../lib/merchant_analyst'
require_relative '../lib/item_analyst'
require_relative '../lib/invoice_analyst'
require 'pry'

class SalesAnalyst

  include MerchantAnalyst
  include ItemAnalyst
  include InvoiceAnalyst

  attr_reader :sales_engine, :invoices, :items,
              :invoice_items, :merchants

  def initialize(sales_engine_from_csv)
    @sales_engine = sales_engine_from_csv
    @invoices = @sales_engine.invoices
    @items = @sales_engine.items
    @invoice_items = @sales_engine.invoice_items
    @merchants = @sales_engine.merchants
  end

  def total_items
    sales_engine.items.count.to_f
  end

  def total_merchants
    sales_engine.merchants.count.to_f
  end

  def total_invoices
    sales_engine.invoices.count.to_f
  end

  def pull_all_merchant_ids
    merchants.merchants.map do |merchant|
      merchant.id
    end
  end


end

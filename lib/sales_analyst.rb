require_relative 'helper'
require_relative 'merchant_analyst'
require_relative 'item_analyst'
require_relative 'invoice_analyst'

class SalesAnalyst

  include Calculator
  include MerchantAnalyst
  include InvoiceAnalyst
  include ItemAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchant_repository
    sales_engine.merchants
  end

  def all_merchants
    merchant_repository.all
  end

  def find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_merchant_items(id)
    find_merchant_by_id(id).items
  end

  def item_repository
    sales_engine.items
  end

  def all_items
    item_repository.all
  end

  def invoice_repository
    sales_engine.invoices
  end

  def all_invoices
    invoice_repository.all
  end
end

require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :items, :merchants, :analyst, :invoices

  def self.from_csv(arg1)
    new(arg1)
  end

  def initialize(arg1)
    @items = ItemRepository.new(arg1[:items], self)
    @merchants = MerchantRepository.new(arg1[:merchants], self)
    @analyst = SalesAnalyst.new(self)
    @invoices = InvoiceRepository.new(arg1[:invoices], self)
  end

  def all_merchants
   @merchants.all
  end

  def find_all_items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def all_items
    @items.all
  end
end

require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'csv'

class SalesEngine
  def self.from_csv(files)
    items = files[:items]
    merchants = files[:merchants]
    invoices = files[:invoices]
    SalesEngine.new(items, merchants, invoices)
  end

  attr_reader :items, :merchants, :invoices

  def initialize(items, merchants, invoices)
    @items = ItemRepository.new(items, self)
    @merchants = MerchantRepository.new(merchants, self)
    @invoices = InvoiceRepository.new(invoices)
  end

  def find_merchant_items(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def find_item_merchant(merchant_id)
    @merchants.find_by_id(merchant_id)
  end


end

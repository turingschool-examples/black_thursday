require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :files, :merchants, :items, :invoices, :invoice_items

  def initialize(files)
    @files = files
    @merchants = MerchantRepository.new(files[:merchants], self)
    @items = ItemRepository.new(files[:items], self)
    @invoices = InvoiceRepository.new(files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(files[:invoice_items], self)
  end

  def self.from_csv(files)
    new(files)
  end

  def items_by_merchant_id(merchant_id)
    @items.find_all_by_merchant_id(merchant_id)
  end

  def merchant_by_merchant_id(merchant_id)
    @merchants.find_by_id(merchant_id)
  end
end

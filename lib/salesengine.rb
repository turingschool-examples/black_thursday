
require_relative 'item_repository'
require_relative 'salesanalyst'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require 'csv'
require 'pry'

class SalesEngine

  attr_reader :items,
              :merchants,
              :salesanalyst,
              :invoices,
              :invoice_items

  def initialize(item_path, merchant_path, invoice_path, invoice_items_path)
    @items = ItemRepository.new(item_path, self)
    @merchants = MerchantRepository.new(merchant_path,self)
    @salesanalyst = SalesAnalyst.new(self)
    @invoices = InvoiceRepository.new(invoice_path,self)
    @invoice_items = InvoiceItemRepository(invoice_items_path,self)
  end

  def self.from_csv(file = {})
    SalesEngine.new(file[:items], file[:merchants], file[:invoices],
    file[:invoice_items])
  end
end

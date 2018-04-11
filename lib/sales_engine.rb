require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :path,
              :items,
              :merchants,
              :invoices,
              :invoice_items

  def initialize(path)
    @items     ||= ItemRepository.new(path[:items], self)
    @merchants ||= MerchantRepository.new(path[:merchants], self)
    @invoices  ||= InvoiceRepository.new(path[:invoices], self)
    @invoice_items ||= InvoiceItemRepository.new(path[:invoice_items], self)
  end

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

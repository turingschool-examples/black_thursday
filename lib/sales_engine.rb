require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'

class SalesEngine

  def self.from_csv(source_files)
    SalesEngine.new(source_files)
  end

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items

  def initialize(source_files)
    @items = ItemRepository.new(source_files[:items], self)
    @merchants = MerchantRepository.new(source_files[:merchants], self)
    @invoices = InvoiceRepository.new(source_files[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(source_files[:invoice_items], self)
  end

end

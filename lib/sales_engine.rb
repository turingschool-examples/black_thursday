require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
# require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'file_reader'

require 'csv'

class SalesEngine
  # builds access to items and merchants
  include FileReader

  def initialize(path)
    @path       = path
    @merchants  = merchants
    @items      = items
    @invoices   = invoices
  end

  def self.from_csv(path)
    new(path)
  end

  def merchants
    @merchants ||= MerchantRepository.new(FileReader.load(@path[:merchants]))
  end

  def items
    @items ||= ItemRepository.new(FileReader.load(@path[:items]))
  end

  def invoices
    @invoices ||= InvoiceRepository.new(FileReader.load(@path[:invoices]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(FileReader.load(@path[:invoice_items]))
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

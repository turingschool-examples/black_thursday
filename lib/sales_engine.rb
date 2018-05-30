require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'file_reader'
require_relative 'invoice_repository'
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

  def analyst
    SalesAnalyst.new(self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(FileReader.load(@path[:invoices]))
  end
end

require 'CSV'
require_relative './file_io'
require_relative './invoice'
require_relative './invoice_repository'
require_relative './item'
require_relative './item_repository'
require_relative './merchant'
require_relative './merchant_repository'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :items, :merchants, :invoices

  def initialize(files)
    @invoices = InvoiceRepository.new(files[:invoices])
    @items = ItemRepository.new(files[:items])
    @merchants = MerchantRepository.new(files[:merchants])
  end

  def self.from_csv(files)
    instance = SalesEngine.new(files)
  end

  def analyst
    SalesAnalyst.new
  end
end

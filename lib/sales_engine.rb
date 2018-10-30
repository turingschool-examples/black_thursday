require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(file_path_hash)
    @merchants = MerchantRepository.new(file_path_hash[:merchants])
    @items = ItemRepository.new(file_path_hash[:items])
    @invoices = InvoiceRepository.new(file_path_hash[:invoices])
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end
end

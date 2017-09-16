require_relative 'item_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine

  def self.from_csv(source_files)
    SalesEngine.new(source_files)
  end

  attr_reader :items,
              :merchants,
              :invoices

  def initialize(source_files)
    @items = ItemRepository.new(source_files[:items], self)
    @merchants = MerchantRepository.new(source_files[:merchants], self)
    @invoices = InvoiceRepository.new(source_files[:invoices], self)
  end

end

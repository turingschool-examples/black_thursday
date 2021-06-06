require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_repository'

class SalesEngine
  attr_reader :items, :merchants, :analyst, :invoices

  def initialize(paths)
    @items     = ItemRepository.new(paths[:items])
    @merchants = MerchantRepository.new(paths[:merchants])
    @invoices  = InvoiceRepository.new(paths[:invoices])
    @analyst   = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    new(paths)
  end
end

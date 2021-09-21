require_relative 'item_repository'
require_relative 'merchants_repository'
require_relative 'data_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst

  def initialize(data_hash)
    @items = ItemRepository.new(data_hash[:items])
    @merchants = MerchantsRepository.new(data_hash[:merchants])
    @invoices = InvoiceRepository.new(data_hash[:invoices])
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices)
  end

  def self.from_csv(data_hash)
    self.new(data_hash)
  end
end

require_relative 'item_repository'
require_relative 'merchants_repository'
require_relative 'data_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :analyst,
              :transactions,
              :invoice_item

  def initialize(data_hash)
    @items = ItemRepository.new(data_hash[:items])
    @merchants = MerchantsRepository.new(data_hash[:merchants])
    @invoices = InvoiceRepository.new(data_hash[:invoices])
    @transactions = TransactionRepository.new(data_hash[:transactions])
    @invoice_items = InvoiceItemRepository.new(data_hash[:invoice_items])
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @transactions, @invoice_items)
  end

  def self.from_csv(data_hash)
    self.new(data_hash)
  end
end

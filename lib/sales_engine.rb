require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
# require_relative 'customer_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def self.from_csv(data)
    @sales_engine = SalesEngine.new(data)
  end

  def initialize(data)
    @items          = ItemRepository.new(data[:items])
    @merchants      = MerchantRepository.new(data[:merchants])
    @invoices       = InvoiceRepository.new(data[:invoices])
    @invoice_items  = InvoiceItemRepository.new(data[:invoice_items])
    @transactions   = TransactionRepository.new(data[:transactions])
    # @analyst = SalesAnalyst.new(self)
    # @customers      = CustomerRepository.new(data[:customers])
  end

  def analyst
    repos = {items: @items, merchants: @merchants}
    SalesAnalyst.new(repos)
  end
end

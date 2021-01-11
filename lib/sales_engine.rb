require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'sales_analyst'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require'csv'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(args)
    # @items         = ItemRepository.new(args[:items], self)
    # @merchants     = MerchantRepository.new(args[:merchants], self)
    @invoices      = InvoiceRepository.new(args[:invoices], self)
    @invoice_items   = InvoiceItemRepository.new(args[:invoice_items], self)
    @customers     = CustomerRepository.new(args[:customers], self)
    # @transactions   = TransactionRepository.new(args[:transactions], self)
  end

  def self.from_csv(args)
    new(args)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

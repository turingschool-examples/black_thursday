
require 'csv'
require 'math_module'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'sales_analyst'
require_relative 'customer'
require_relative 'customer_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :merchants,
              :items,
              :analyst,
              :invoices,
              :customers,
              :invoice_items,
              :transactions

  def initialize(paths)
    @merchants = MerchantRepository.new(paths[:merchants], self)
    @items = ItemRepository.new(paths[:items], self)
    @invoices = InvoiceRepository.new(paths[:invoices], self)
    @customers = CustomerRepository.new(paths[:customers], self)
    @invoice_items = InvoiceItemRepository.new(paths[:invoice_items], self)
    @transactions = TransactionRepository.new(paths[:transactions], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(paths)
    SalesEngine.new(paths)
  end
end

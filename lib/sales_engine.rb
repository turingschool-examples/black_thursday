require 'csv'
require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'merchantrepository'
require_relative 'itemrepository'
require_relative 'invoicerepository'
require_relative 'invoice_item_repo'
require_relative 'transactionrepository'
require_relative 'customerrepository'
require_relative 'sales_analyst'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'customer'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers
  attr_accessor :analyst
  def initialize(data)
    @items     = ItemRepository.new(data[:items], self)
    @merchants = MerchantRepository.new(data[:merchants], self)
    @invoices = InvoiceRepository.new(data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items], self)
    @transactions = TransactionRepository.new(data[:transactions], self)
    @customers = CustomerRepository.new(data[:customers], self)
    @analyst = SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions)
  end

  def self.from_csv(info)
    SalesEngine.new(info)
  end
end

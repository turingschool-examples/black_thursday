require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def initialize(repositories)
    @items        = ItemRepository.new(repositories[:items], self)
    @merchants    = MerchantRepository.new(repositories[:merchants], self)
    @invoices     = InvoiceRepository.new(repositories[:invoices], self)
    @transactions = TransactionRepository.new(repositories[:transactions], self)
    @customers    = CustomerRepository.new(repositories[:customers], self)
  end
end

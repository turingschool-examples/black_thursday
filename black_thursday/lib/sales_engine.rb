require 'csv'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'item_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def initialize(repositories)
    @items        = ItemRepository.new(repositories[:items], self)
    @merchants    = MerchantRepository.new(repositories[:merchants], self)
    @invoices     = InvoiceRepository.new(repositories[:invoices], self)
    @transactions = TransactionRepository.new(repositories[:transactions], self)
  end
end

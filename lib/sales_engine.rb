require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'item'
require_relative 'invoice_repository'
require_relative 'invoice'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'sales_analyst'

class SalesEngine
  def self.from_csv(file_hash)
    items = []
    CSV.foreach(file_hash[:items], headers: true, header_converters: :symbol) do |row|
      items << Item.new(row)
    end
    merchants = []
    CSV.foreach(file_hash[:merchants], headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end
    invoices = []
    CSV.foreach(file_hash[:invoices], headers: true, header_converters: :symbol) do |row|
      invoices << Invoice.new(row)
    end
    transactions = []
    CSV.foreach(file_hash[:transactions], headers: true, header_converters: :symbol) do |row|
      transactions << Transaction.new(row)
    end
    SalesEngine.new(items, merchants, invoices, transactions)
  end

  attr_reader :items,
              :merchants,
              :invoices,
              :transactions

  def initialize(items, merchants, invoices, transactions)
    @items = ItemRepository.new(items)
    @merchants = MerchantRepository.new(merchants)
    @invoices = InvoiceRepository.new(invoices)
    @transactions = TransactionRepository.new(transactions)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @transactions)
  end
end

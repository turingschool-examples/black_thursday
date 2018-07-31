
require 'csv'
require_relative './item'
require_relative './merchant'
require_relative './invoice'
require_relative'../lib/transaction.rb'
require_relative './invoice_item'
require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative'../lib/transaction_repository.rb'
require_relative './sales_analyst'

class SalesEngine
  attr_reader :csv_hash,
              :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions
  def initialize(csv_hash)# keys: items, merchants; values: paths to csv files
    @csv_hash = csv_hash
    @items = ItemRepository.new(csv_hash[:items])
    @items.create_items
    @merchants = MerchantRepository.new(csv_hash[:merchants])
    @merchants.create_all_from_csv(csv_hash[:merchants])
    @invoices = InvoiceRepository.new(csv_hash[:invoices])
    @invoices.create_invoices
    @invoice_items = InvoiceItemRepository.new(csv_hash[:invoice_items])
    @invoice_items.create_invoice_items
    @transactions = TransactionRepository.new(csv_hash[:transactions])
    @transactions.create_transactions
  end

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

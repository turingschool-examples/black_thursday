require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice_item_repository'
require_relative './customer_repository'
require_relative './transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(file_path_hash)
    @merchants = MerchantRepository.new(file_path_hash[:merchants])
    @items = ItemRepository.new(file_path_hash[:items])
    @invoices = InvoiceRepository.new(file_path_hash[:invoices])
    @invoice_items = InvoiceItemRepository.new(file_path_hash[:invoice_items])
    @customers = CustomerRepository.new(file_path_hash[:customers])
    @transactions = TransactionRepository.new(file_path_hash[:transactions])
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)
  end
end

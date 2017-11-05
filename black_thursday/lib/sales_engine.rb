require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'invoice_item_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :transactions,
              :customers,
              :invoice_items

  def self.from_csv(csv_files)
    SalesEngine.new(csv_files)
  end

  def initialize(repositories)
    @items        = ItemRepository.new(repositories[:items], self)
    @merchants    = MerchantRepository.new(repositories[:merchants], self)
    @invoices     = InvoiceRepository.new(repositories[:invoices], self)
    @transactions = TransactionRepository.new(repositories[:transactions], self)
    @customers    = CustomerRepository.new(repositories[:customers], self)
    @invoice_items = InvoiceItemRepository.new(repositories[:invoice_items], self)
  end

  def find_invoices_by_merchant(id)
    invoices.find_all_by_merchant_id(id)
  end

end

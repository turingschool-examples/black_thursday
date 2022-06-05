require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(items_filepath, merchants_filepath, invoice_filepath, invoice_item_filepath, transaction_filepath, customer_filepath)
    @items = ItemRepository.new(items_filepath)
    @merchants = MerchantRepository.new(merchants_filepath)
    @invoices = InvoiceRepository.new(invoice_filepath)
    @invoice_items = InvoiceItemRepository.new(invoice_item_filepath)
    @transactions = TransactionRepository.new(transaction_filepath)
    @customers = CustomerRepository.new(customer_filepath)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:transactions], data[:customers])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions, @customers)
  end
end

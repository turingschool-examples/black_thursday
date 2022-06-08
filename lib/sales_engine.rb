require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items, :merchants, :invoice,
  :invoices, :invoice_items, :transactions, :customers

  def initialize(
    items_path,
    merchant_path,
    invoices_path,
    invoice_item_path,
    transaction_path,
    customer_path
  )
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchant_path)
    @invoices = InvoiceRepository.new(invoices_path)
    @invoice_items = InvoiceItemRepository.new(invoice_item_path)
    @transactions = TransactionRepository.new(transaction_path)
    @customers = CustomerRepository.new(customer_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:transactions], data[:customers])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions, @customers)
  end
end

require_relative 'item'
require_relative 'item_repository'
require_relative 'merchant'
require_relative 'merchant_repository'
require_relative 'invoice'
require_relative 'invoice_repository'
require_relative 'invoice_item'
require_relative 'invoice_item_repository'
require_relative 'transaction'
require_relative 'transaction_repository'
require_relative 'customer'
require_relative 'customer_repository'


class SalesEngine

  attr_reader :merchants, :items, :invoices, :invoice_items, :transactions, :customers

  def initialize(items_path, merchants_path, invoice_path, invoice_item_path, transaction_path, customer_path)
    @items_path = items_path
    @merchants_path = merchants_path
    @invoice_path = invoice_path
    @invoice_item_path = invoice_item_path
    @transaction_path = transaction_path
    @customer_path = customer_path
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoice_path)
    @invoice_items = InvoiceItemRepository.new(invoice_item_path)
    @transactions = TransactionRepository.new(transaction_path)
    @customers = CustomerRepository.new(customer_path)

  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:transactions], data[:customers])
  end

  def analyst
    SalesAnalyst.new(@items_path,@merchants_path,@invoice_path,@invoice_item_path,@transaction_path,@customer_path)
  end
end

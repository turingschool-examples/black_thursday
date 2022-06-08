require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions

  def initialize(items_path, merchants_path, invoices_path, invoice_items_path, customers_path, transactions_path)
    @items = ItemRepository.new(items_path)
    @merchants = MerchantRepository.new(merchants_path)
    @invoices = InvoiceRepository.new(invoices_path)
    @invoice_items = InvoiceItemRepository.new(invoice_items_path)
    @customers = CustomerRepository.new(customers_path)
    @transactions = TransactionRepository.new(transactions_path)
  end

  def self.from_csv(data)
    SalesEngine.new(data[:items], data[:merchants], data[:invoices], data[:invoice_items], data[:customers], data[:transactions])
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions )
  end
end

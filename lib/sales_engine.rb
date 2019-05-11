require 'bigdecimal'
require 'csv'
require 'time'
require_relative 'file_io'
require_relative 'repositories/customer_repository'
require_relative 'repositories/invoice_item_repository'
require_relative 'repositories/invoice_repository'
require_relative 'repositories/item_repository'
require_relative 'repositories/merchant_repository'
require_relative 'repositories/transaction_repository'
require_relative 'repositories/repository'
require_relative 'sales_analyst'

# Sales Engine class for managing data
class SalesEngine
  attr_reader :customers,
              :invoices,
              :invoice_items,
              :items,
              :merchants,
              :transactions

  def initialize(attrs)
    @customers = attrs[:customer_repo]
    @invoices = attrs[:invoice_repo]
    @invoice_items = attrs[:invoice_item_repo]
    @items = attrs[:item_repo]
    @merchants = attrs[:merchant_repo]
    @transactions = attrs[:transaction_repo]
  end

  def self.from_csv(file = Hash.new(0))
    customers_data = FileIO.load(file[:customers])
    invoices_data = FileIO.load(file[:invoices])
    invoice_items_data = FileIO.load(file[:invoice_items])
    items_data = FileIO.load(file[:items])
    merchants_data = FileIO.load(file[:merchants])
    transactions_data = FileIO.load(file[:transactions])
    attrs = {
      customer_repo: CustomerRepository.new(customers_data),
      invoice_item_repo: InvoiceItemRepository.new(invoice_items_data),
      invoice_repo: InvoiceRepository.new(invoices_data),
      item_repo: ItemRepository.new(items_data),
      merchant_repo: MerchantRepository.new(merchants_data),
      transaction_repo: TransactionRepository.new(transactions_data)
    }
    new(attrs)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

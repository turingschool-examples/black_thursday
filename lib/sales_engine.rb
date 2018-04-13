require 'bigdecimal'
require 'csv'
require 'time'
require_relative 'fileio'
require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoiceitem_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'
require_relative 'repository'
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

  def self.from_csv(data = Hash.new(0))
    customers_file_path = FileIO.load(data[:customers])
    invoices_file_path = FileIO.load(data[:invoices])
    invoice_items_file_path = FileIO.load(data[:invoice_items])
    items_file_path = FileIO.load(data[:items])
    merchants_file_path = FileIO.load(data[:merchants])
    transactions_file_path = FileIO.load(data[:transactions])
    attrs = {
      customer_repo: CustomerRepository.new(customers_file_path),
      invoice_items_repo: InvoiceItemRepository.new(invoice_items_file_path),
      invoice_repo: InvoiceRepository.new(invoices_file_path),
      item_repo: ItemRepository.new(items_file_path),
      merchant_repo: MerchantRepository.new(merchants_file_path),
      transaction_repo: TransactionRepository.new(transactions_file_path)
    }
    new(attrs)
  end

  def analyst
    SalesAnalyst.new(self)
  end
end

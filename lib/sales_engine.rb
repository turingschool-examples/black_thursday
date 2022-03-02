require 'csv'
require 'pry'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'sales_analyst'

class SalesEngine
attr_reader :merchants, :items, :invoices, :invoice_items, :customers, :transactions
  def initialize(merchants, items, invoices, invoice_items, customers, transactions)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
    @invoices = InvoiceRepository.new(invoices)
    @invoice_items = InvoiceItemRepository.new(invoice_items)
    @customers = CustomerRepository.new(customers)
    @transactions = TransactionRepository.new(transactions)
  end

  def self.from_csv(input)
    merchant_lines = input[:merchants]
    item_lines = input[:items]
    invoice_lines = input[:invoices]
    invoice_item_lines = input[:invoice_items]
    customer_lines = input[:customers]
    transaction_lines = input[:transactions]
    SalesEngine.new(merchant_lines, item_lines, invoice_lines, invoice_item_lines, customer_lines, transaction_lines)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items, @customers, @transactions)
  end
end

require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/invoice_item.rb'
require_relative '../lib/invoice_item_repository.rb'
require_relative '../lib/transaction.rb'
require_relative '../lib/transaction_repository.rb'
require_relative '../lib/invoice.rb'
require_relative '../lib/invoice_repository.rb'
require_relative '../lib/customer.rb'
require_relative '../lib/customer_repository.rb'
require_relative '../lib/sales_analyst.rb'

require 'pry'

class SalesEngine
  attr_reader :merchants,
              :items,
              :invoices,
              :analyst,
              :invoice_items,
              :transactions,
              :customers

  def initialize(merchants, items, invoices, invoice_items, transactions, customers)
    @merchants = MerchantRepository.new(merchants)
    @items = ItemRepository.new(items)
    @invoices = InvoiceRepository.new(invoices)
    @invoice_items = InvoiceItemRepository.new(invoice_items)
    @transactions = TransactionRepository.new(transactions)
    @customers = CustomerRepository.new(customers)
    @analyst = SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items, @transactions, @customers)

  end

  def self.from_csv(csv_hash)
    merchants = []
    CSV.foreach(csv_hash[:merchants], headers: true, header_converters: :symbol) do |row|
      merchants << Merchant.new(row)
    end
    items = []
    CSV.foreach(csv_hash[:items], headers: true, header_converters: :symbol) do |row|
      items << Item.new(row)
    end
    invoices = []
    CSV.foreach(csv_hash[:invoices], headers: true, header_converters: :symbol) do |row|
      invoices << Invoice.new(row)
    end
    invoice_items = []
    CSV.foreach(csv_hash[:invoice_items], headers: true, header_converters: :symbol) do |row|
      invoice_items << InvoiceItem.new(row)
    end
    transactions = []
    CSV.foreach(csv_hash[:transactions], headers: true, header_converters: :symbol) do |row|
      transactions << Transaction.new(row)
    end
    customers = []
    CSV.foreach(csv_hash[:customers], headers: true, header_converters: :symbol) do |row|
      customers << Customer.new(row)
    end

    # item_location = csv_hash[:items]
    # invoice_location = csv_hash[:invoices]
    # invoice_item_location = csv_hash[:invoice_items]
    # transaction_location = csv_hash[:transactions]
    # customer_location = csv_hash[:customers]
    SalesEngine.new(merchants, items, invoices, invoice_items, transactions, customers)
  end
end

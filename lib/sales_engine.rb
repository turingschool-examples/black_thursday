require 'csv'
require_relative '../lib/merchant.rb'
require_relative '../lib/merchant_repository.rb'
require_relative '../lib/item_repository.rb'
require_relative '../lib/invoice_item_repository.rb'
require_relative '../lib/transaction_repository.rb'
require_relative '../lib/invoice_repository.rb'
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

  def initialize(merchant_location, item_location, invoice_location, invoice_item_location, transaction_location, customer_location)
    @merchants = MerchantRepository.new(merchant_location)
    @items = ItemRepository.new(item_location)
    @invoices = InvoiceRepository.new(invoice_location)
    @invoice_items = InvoiceItemRepository.new(invoice_item_location)
    @transactions = TransactionRepository.new(transaction_location)
    @customers = CustomerRepository.new(customer_location)
    @analyst = SalesAnalyst.new(@merchants, @items, @invoices, @invoice_items, @transactions, @customers)

  end

  def self.from_csv(csv_hash)
    merchant_location = csv_hash[:merchants]
    item_location = csv_hash[:items]
    invoice_location = csv_hash[:invoices]
    invoice_item_location = csv_hash[:invoice_items]
    transaction_location = csv_hash[:transactions]
    customer_location = csv_hash[:customers]
    SalesEngine.new(merchant_location, item_location, invoice_location, invoice_item_location, transaction_location, customer_location)
  end
end

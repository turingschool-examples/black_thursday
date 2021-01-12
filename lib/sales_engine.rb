require 'csv'
require 'pry'
require_relative './merchant_repository'
require_relative './merchant'
require_relative './item_repository'
require_relative './item'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './sales_analyst'
require_relative './invoice_item_repository'
require_relative './invoice_item'
require_relative './transaction_repository'
require_relative './transaction'
require_relative './customer_repository'
require_relative './customer'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def initialize(sales_data)
    @items = ItemRepository.new(sales_data[:items], self)
    @merchants = MerchantRepository.new(sales_data[:merchants], self)
    @invoices = InvoiceRepository.new(sales_data[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(sales_data[:invoice_items], self)
    @transactions = TransactionRepository.new(sales_data[:transactions], self)
    @customers = CustomerRepository.new(sales_data[:customers], self)
    @analyst = SalesAnalyst.new(self)
  end

  def self.from_csv(sales_data)
    SalesEngine.new(sales_data)
  end
end

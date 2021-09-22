require './lib/sales_analyst'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/transaction_repository'
require './lib/customer_repository'
require './lib/item'
require './lib/merchant'
require './lib/invoice'
require './lib/invoice_item'
require './lib/transaction'
require './lib/customer'
require 'csv'
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def initialize(data)
    @items = ItemRepository.new(data[:items])
    @merchants = MerchantRepository.new(data[:merchants])
    @invoices = InvoiceRepository.new(data[:invoices])
    @invoice_items = InvoiceItemRepository.new(data[:invoice_items])
    @transactions = TransactionRepository.new(data[:transactions])
    @customers = CustomerRepository.new(data[:customers])
    @analyst = SalesAnalyst.new({
                                 :items => @items,
                                 :merchants => @merchants,
                                 :invoices => @invoices,
                                 :invoice_items => @invoice_items,
                                 :transactions => @transactions,
                                 :customers => @customers
                                 })
  end
end

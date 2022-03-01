require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'customer_repository'
require_relative 'sales_analyst'
require_relative 'transaction_repository'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash, :invoices, :invoice_items, :transactions, :customers
  def initialize(items, merchants, invoices, invoice_items, transactions, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
    @customers = customers
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    @invoices = InvoiceRepository.new(info[:invoices])
    @invoice_items = InvoiceItemRepository.new(info[:invoice_items])
    @transactions = TransactionRepository.new(info[:transactions])
    @customers = CustomerRepository.new(info[:customers])
    new(@items, @merchants, @invoices, @invoice_items, @transactions, @customers)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @invoice_items, @transactions, @customers)
  end


end

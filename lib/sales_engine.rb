require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'sales_analyst'
require_relative 'transaction_repository'
require 'pry'

class SalesEngine
  attr_accessor :items, :merchants, :hash, :invoices, :invoice_items, :transaction_repository
  def initialize(items, merchants, invoices, invoice_items, transaction_repository)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
  end

  def self.from_csv(info)
    @items = ItemRepository.new(info[:items])
    @merchants = MerchantRepository.new(info[:merchants])
    @invoices = InvoiceRepository.new(info[:invoices])
    @invoice_items = InvoiceItemRepository.new(info[:invoice_items])
    @transactions = TransactionRepository.new(info[:transactions])
    new(@items, @merchants, @invoices, @invoice_items, @transactions)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items, @invoices)
  end


end

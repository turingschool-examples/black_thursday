require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'sales_analyst'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers,
              :analyst

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def initialize(data)
    @items          = data[:items]
    @merchants      = data[:merchants]
    @invoices       = data[:invoices]
    @invoice_items  = data[:invoice_items]
    @transactions   = data[:transactions]
    @customers      = data[:customers]
  end

  def items
    ItemRepository.new(@items) if @items
  end

  def merchants
    MerchantRepository.new(@merchants) if @merchants
  end

  def invoices
    InvoiceRepository.new(@invoices) if @invoices
  end

  def invoice_items
    InvoiceItemRepository.new(@invoice_items) if @invoice_items
  end

  def transactions
    TransactionRepository.new(@transactions) if @transactions
  end

  def customers
    CustomerRepository.new(@customers) if @customers
  end

  def analyst
    SalesAnalyst.new
  end
end

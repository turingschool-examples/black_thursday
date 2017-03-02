require 'csv'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require 'pry'

class SalesEngine
  attr_reader :items, :merchants, :invoices, :invoice_items, :transactions, :customers
  def initialize(csv_hash)
    @item_csv = csv_hash[:items]
    @merchant_csv = csv_hash[:merchants]
    @invoice_csv = csv_hash[:invoices]
    @invoice_items_csv = csv_hash[:invoice_items]
    @transactions_csv = csv_hash[:transactions]
    @customers_csv = csv_hash[:customers]
    @items = ItemRepository.new(@item_csv, self)
    @merchants = MerchantRepository.new(@merchant_csv, self)
    @invoices = InvoiceRepository.new(@invoice_csv, self)
    @invoice_items = InvoiceItemRepository.new(@invoice_items_csv, self)
    @transactions = TransactionRepository.new(@transactions_csv, self)
    @customers = CustomerRepository.new(@customers_csv, self)
  end

  def self.from_csv(csv_hash)
    SalesEngine.new(csv_hash)
  end


end

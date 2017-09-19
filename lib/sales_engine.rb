require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'customer_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'

class SalesEngine

  attr_reader :items, :merchants, :invoices, :customers, :transactions, :invoice_items

  def self.from_csv(csv_file_paths)
    item_file_path = csv_file_paths[:items]
    merchant_file_path = csv_file_paths[:merchants]
    invoice_file_path = csv_file_paths[:invoices]
    invoice_item_file_path = csv_file_paths[:invoice_items]
    customer_file_path = csv_file_paths[:customers]
    transaction_file_path = csv_file_paths[:transactions]

    SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
  end


  def initialize(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @items = ItemRepository.new(item_file_path, self)
    @merchants = MerchantRepository.new(merchant_file_path, self)
    @invoices = InvoiceRepository.new(invoice_file_path, self)
    @invoice_items = InvoiceItemRepository.new(invoice_item_file_path, self)
    @customers = CustomerRepository.new(customer_file_path, self)
    @transactions = TransactionRepository.new(transaction_file_path, self)
  end

  def item_list
    @items.items
  end

  def merchant_list
    @merchants.merchants
  end

  def invoice_list
    @invoices.invoices
  end

  def invoice_item_list
    @invoice_items.invoice_items
  end

  def customer_list
    @customers.customers
  end

  def transaction_list
    @transactions.transactions
  end

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end


end
